;;; Package-declare -- declare package using require-package or maybe-require-package and load config if needed
;;; Commentary:
;;; Code:

(require 'init-theme)
(require 'init-evil)
(require 'init-projectile)
(require 'init-helm)

(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require-package 'autopair)
(add-hook 'after-init-hook #'autopair-global-mode)

(require-package 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(require-package 'which-key)
(which-key-setup-side-window-right-bottom)
(add-hook 'after-init-hook #'which-key-mode)

(require-package 'color-identifiers-mode)
(add-hook 'after-init-hook #'global-color-identifiers-mode)

(require-package 'company)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)
(add-hook 'after-init-hook #'global-company-mode)

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)

(require-package 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
          "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
(setq markdown-command "pandoc")

(require-package 'magit)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

(require-package 'edit-indirect)

(add-hook 'rust-mode-hook #'cargo-minor-mode)
(add-hook 'rust-mode-hook #'racer-mode)

(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(setq rust-format-on-save t)

(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(require-package 'yasnippet)
(yas-global-mode)
(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "->") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
    (minibuffer-complete)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
      (if (check-expansion)
        (company-complete-common)
        (indent-for-tab-command)))))

(global-set-key [tab] 'tab-indent-or-complete)


(require 'init-irony)


(require-package 'helm-company)
(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))


(require-package 'ethan-wspace)
(setq mode-require-final-newline nil)
(global-ethan-wspace-mode 1)

(require-package 'smooth-scrolling)
(smooth-scrolling-mode 1)

(provide 'packages-declare)
;;; packages-declare.el ends here
