;;; package --- Init irony
;;; Commentary:
;;; Code:

(require-package 'irony)
(require-package 'company-irony)
(require-package 'flycheck-irony)


(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(provide 'init-irony)
;;; init-irony.el ends here
