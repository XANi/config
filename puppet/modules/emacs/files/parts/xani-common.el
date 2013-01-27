;;; cfg-orgmode.el ---
;; common includes and configuration

;; auto GPG
(epa-file-enable)

;; expand comment to next line if previous line was a comment
(global-set-key (kbd "RET") 'comment-indent-new-line)

;; fix yes no questions
(fset 'yes-or-no-p 'y-or-n-p)


;; use ibuffer by default
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;; remove trailing whitespace xcept on some "special" paths
(defun auto-whitespace-remove ()
  ;; haproxy needs spaces in some edge cases
  (if (string-match "haproxy" buffer-file-name) nil (delete-trailing-whitespace))
)
(add-hook 'before-save-hook 'auto-whitespace-remove)

;; I edit configs a lot so if it's unknown file it's probably a config
(setq-default major-mode 'conf-mode)
(global-set-key [(control x) (k)] '(lambda ()
  (interactive)
  (if server-buffer-clients
      (server-edit)
    (kill-this-buffer)))
) ;; we always use server mode here do replace default kill with server-edit

(global-linum-mode 1)  ;; show line numbers in marigin, need newer emacs than centos 5 one
(global-hl-line-mode 1) ;; highlight current line - looks ugly on emacs21 coz no 256 color support on centos

;; default printing program:
(setq lpr-command "gtklp")


(setq
 display-time-day-and-date t
 display-time-24hr-format t)
(display-time)

(show-paren-mode) ;; show matching ()
(column-number-mode 1) ;; and column at bot
(setq-default fill-column 120)

(setq
  backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saved"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 4
 kept-old-versions 0
 tab-width 4
 color-theme-is-global t
 version-control t       ; use versioned backups
 yaml-block-literal-search-lines 1000
 yaml-indent-offset 4
 )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(indent-tabs-mode nil)
 '(standard-indent 4)
 '(tab-width 4)
 '(enable-recursive-minibuffers t)
 '(case-fold-search t)
 '(current-language-anvironment "UTF-8")
 '(display-time-mail-file (quote none))
 '(display-time-use-mail-icon t)
 '(file-cache-completion-ignore-case t)
 '(global-font-lock-mode t nil (font-lock))
 '(gnuserv-program (concat exec-directory "/gnuserv"))
 '(inhibit-startup-screen t)
 '(ibuffer-default-sorting-mode (quote major-mode))
 '(ibuffer-default-sorting-reversep t)
 '(load-home-init-file t t)
 '(mouse-yank-at-point 1)
 ;; magick needed to make jabber-mode work with gmail and arte jabber servers
 '(starttls-extra-arguments (quote ("--insecure")))
;; for wanderlust
 '(ssl-certificate-verification-policy 0)
 '(ssl-program-arguments (quote ("--insecure" "-p" service host)))
 '(ssl-program-name "gnutls-cli")
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(uniquify-min-dir-content 2)
 '(whitespace-line-column 200)
 '(whitespace-style (quote (face tabs trailing lines tab-mark)))
)

;; Show tabs with the same color as trailing whitespace
;; (add-hook 'font-lock-mode-hook
;;   (lambda ()
;;     (font-lock-add-keywords
;;       nil
;;       '(("\t" 0 'trailing-whitespace prepend)))))

(global-whitespace-mode)

;; do not ask for kill confirmation on flymake process
(defadvice flymake-start-syntax-check-process (after
                                               cheeso-advice-flymake-start-syntax-check-1
                                               (cmd args dir)
                                               activate compile)
  ;; set flag to allow exit without query on any
  ;;active flymake processes
  (set-process-query-on-exit-flag ad-return-value nil))


(provide 'xani-common)

