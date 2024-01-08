;;; init-theme.el

(require-package 'gruvbox-theme)

(setq-default custom-theme-dark 'gruvbox-dark-medium)
(setq-default custom-theme-light 'gruvbox-light-medium)

(setq-default custom-enabled-themes (list custom-theme-dark))


;; Ensure that themes will be applied even if they have not been customized
(defun reapply-themes ()
  "Forcibly load the themes listed in `custom-enabled-themes'."
  (dolist (theme custom-enabled-themes)
    (unless (custom-theme-p theme)
      (load-theme theme)))
  (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes))))


(defun light () 
  "Activate light color theme"
  (interactive)
  (setq custom-enabled-themes custom-theme-light)
  (reapply-themes)
)

(defun dark () 
  "Activate dark color theme"
  (interactive)
  (setq custom-enabled-themes 'custom-theme-dark)
  (reapply-themes)
)

(add-hook 'after-init-hook 'reapply-themes)

(when (maybe-require-package 'dimmer)
  (dimmer-mode))

(provide 'init-theme)
