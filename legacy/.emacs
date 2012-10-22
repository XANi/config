(iswitchb-mode)
;; dont clutter fs with backup~ files, put them in home
;; (setq
;;    backup-by-copying t      ; don't clobber symlinks
;;    backup-directory-alist
;;     '(("." . "~/.saved"))    ; put backups in one directory
;;    delete-old-versions t
;;    kept-new-versions 4
;;    kept-old-versions 0
;;    version-control t)       ; use versioned backups

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(c-indent-comments-syntactically-p t)
 '(c-set-style "K&R")
 '(current-language-anvironment "UTF-8")
 '(case-fold-search t)
 '(cperl-indent-level 4)
 '(global-font-lock-mode t nil (font-lock))
 '(gnuserv-program (concat exec-directory "/gnuserv"))
 '(inhibit-startup-screen t)
 '(load-home-init-file t t)
 '(standard-indent 4)
 '(setq-default indent-tabs-mode nil)
 '(tab-width 4))
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
(if window-system ;; X config
 '(default ((t (:inherit nil :stipple nil :background "gray12" :foreground "green" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 88 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))) ;; console config
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "gray" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 88 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))))
(require 'color-theme)

(add-to-list 'load-path "~/zencoding/")
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode)
(setq auto-mode-alist (cons '("*.c" . linux-c-mode)
			    auto-mode-alist))
(setq color-theme-is-global t)
;; (tabbar-mode)
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))
(add-to-list 'load-path "~/zencoding/")
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode)

;;Auto-start on any markup modes
;; (server-start)
;; (dolist (func '(tabbar-mode tabbar-forward-tab tabbar-forward-group tabbar-backward-tab tabbar-backward-group))
;;   (autoload func "tabbar" "Tabs at the top of buffers and easy control-tab navigation"))

;; (defmacro defun-prefix-alt (name on-no-prefix on-prefix &optional do-always)
;;   `(defun ,name (arg)
;;      (interactive "P")
;;      ,do-always
;;      (if (equal nil arg)
;;  ,on-no-prefix
;;        ,on-prefix)))

;; (defun-prefix-alt shk-tabbar-next (tabbar-forward-tab) (tabbar-forward-group) (tabbar-mode 1))
;; (defun-prefix-alt shk-tabbar-prev (tabbar-backward-tab) (tabbar-backward-group) (tabbar-mode 1))

;; (global-set-key [(control tab)] 'shk-tabbar-next)
;; (global-set-key [(control shift tab)] 'shk-tabbar-prev)

(add-hook 'window-configuration-change-hook
	  (lambda ()
	    (setq frame-title-format
		  (concat
		   invocation-name "@" system-name ": "
		   (replace-regexp-in-string
		    (concat "/home/" user-login-name) "~"
		    (or buffer-file-name "%b"))))))
