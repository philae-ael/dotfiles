-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local mocha = require("catppuccin.palettes").get_palette "mocha"

local colors = vim.tbl_extend("keep", mocha, {
  fg = mocha.text,
  bg = mocha.base,
  cyan = mocha.teal,
  orange = mocha.maroon,
  violet = mocha.mauve
})

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = "catppuccin",
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_left_inactive(component)
  table.insert(config.inactive_sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    return '▊'
  end,
  color = { fg = colors.blue },      -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
  'mode',
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.mauve,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

-- ins_left {
--   -- filesize component
--   'filesize',
--   cond = conditions.buffer_not_empty,
-- }

ins_left {
  'buffers',
  mode = 2,
  symbols = {
    modified = ' ●',
    alternate_file = '',
    directory = '',
  },
  buffers_color = {
    active = { bg = colors.bg, fg = colors.green },
    inactive = { bg = colors.bg_dark, fg = colors.fg },
  },
}


ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

ins_left {
  function()
    return '%='
  end,
}

ins_left_inactive {
  function()
    return '%='
  end,
}

ins_left {
  'filename',
  file_status = true,
  path = 4,
  symbols = {
    modified = '',
    readonly = '[ro]',
    unnamed = '[No Name]',
    newfile = '[New]',
  }
}

ins_left_inactive {
  'filename',
  file_status = true,
  path = 4,
  symbols = {
    modified = '',
    readonly = '[ro]',
    unnamed = '[No Name]',
    newfile = '[New]',
  }
}

ins_right {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
}

ins_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_right { 'location' }

ins_right {
  function()
    local mode = vim.fn.mode(true)
    local pos_start = vim.fn.getpos('v')
    local pos_end = vim.fn.getpos('.')
    local line_start, col_start = pos_start[2], pos_start[3] + pos_start[4]
    local line_end, col_end = pos_end[2], pos_end[3] + pos_end[4]
    if mode:match('') then
      return string.format('%dx%d', math.abs(line_start - line_end) + 1, math.abs(col_start - col_end) + 1)
    elseif mode:match('V') or line_start ~= line_end then
      return math.abs(line_start - line_end) + 1
    elseif mode:match('v') then
      return math.abs(col_start - col_end) + 1
    else
      return ''
    end
  end
  ,
  color = { fg = colors.yellow }
}

ins_right { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_right {
  function()
    return '▊'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

vim.opt.showmode = false
-- Now don't forget to initialize lualine
lualine.setup(config)
