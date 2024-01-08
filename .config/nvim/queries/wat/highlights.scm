; keywords
[
  "module"
  "func"
  "global"
  "export"
  "import"
  "memory"
  "data"
  "if"
  "then"
  "else"
  "block"
  "loop"
  "end"
  "mut"
  "param"
  "result"
  "local"
] @keyword

; comments
[
  (comment_block)
  (comment_line)
] @comment

; literals
(string) @string
[
  (int) 
  (float)
] @number

(escape_sequence) @escape

; functions
(export_desc_func
  (index) @function
)
(export_desc_func
  (index) @funtion
)
(import_desc_func_type
  (identifier) @function
)
(module_field_func
  (identifier) @function
)
(type_field
  (func_type) @function
)

; parameters
(func_type_params_one
  (identifier) @variable.parameter
)
