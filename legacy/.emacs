(add-to-list 'load-path "~/zencoding/")
(add-to-list 'load-path "~/src/emacs")
(iswitchb-mode) ;; better buffer switching
(show-paren-mode) ;; show matching ()
(global-hl-line-mode 1) ;; lhighlight current line
(global-linum-mode 1)  ;; show line numbers in marigin
(column-number-mode 1) ;; and column at bot
(setq-default fill-column 120)
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 4
 kept-old-versions 0
 version-control t)       ; use versioned backups
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
 (require 'color-theme-sanityinc-solarized)
 (if window-system
     (color-theme-sanityinc-solarized-dark)
   '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 88 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))))
(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 4))

(setq auto-mode-alist (cons '("*.c" . linux-c-mode)
                            auto-mode-alist))
(setq color-theme-is-global t)
;; (tabbar-mode)
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.\\([pP][pP]\\)\\'" . puppet-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))
(require 'puppet-mode)
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

(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  )
(toggle-fullscreen)
(add-hook 'window-configuration-change-hook
          (lambda ()
            (setq frame-title-format
                  (concat
                   invocation-name "@" system-name ": "
                   (replace-regexp-in-string
                    (concat "/home/" user-login-name) "~"
                    (or buffer-file-name "%b"))))))

(setq develock-max-column-plist
      (list 'emacs-lisp-mode t
            'lisp-interaction-mode 'w
            'change-log-mode t
            'texinfo-mode t
            'c-mode t
            'c++-mode t
            'java-mode t
            'jde-mode t
            'html-mode t
            'html-helper-mode t
            'cperl-mode t
            'perl-mode t
            'mail-mode t
            'message-mode t
            'cmail-mail-mode t
            'tcl-mode t
            'ruby-mode t)
      )
