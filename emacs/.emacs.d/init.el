;;; init.el --- The init script
;;; Code:

(set-language-environment "UTF-8")
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))


;; Remove menu-bat, scroll-bar, etc. in GUI
;;(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen
(setq inhibit-startup-screen t)

;; Line No
(global-linum-mode 1)

(setq backup-by-copying t)
(setq backup-directory-alist `(("." . "~/.saves")))


;; Tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4) ; or any other preferred value
(setq indent-line-function 'insert-tab)
(global-set-key (kbd "DEL") 'backward-delete-char)

(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-packages)
(require 'packages-declare)

(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)
;;; init.el ends here
