;;; Package-declare -- declare package using require-package or maybe-require-package and load config if needed

(require 'init-theme)
(require 'init-evil)

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

;; (require-package 'yasnippet)

(provide 'packages-declare)
