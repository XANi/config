;; <%= @puppet_header %>
;; <%=  __FILE__.gsub(/.*?repos/,@fqdn + ':') %>

;; hide-show mode
(global-set-key (kbd "<C-tab>") 'hs-toggle-hiding)
(global-set-key (kbd "RET") 'comment-indent-new-line)

  ;; (defun my-yes-or-mumble-p (prompt)
  ;;   "PROMPT user with a yes-or-no question, but only test for yes."
  ;;   (if (string= "yes"
  ;;                (downcase
  ;;                 (read-from-minibuffer
  ;;                  (concat prompt "(yes or no) "))))
  ;;       t
  ;;     nil))

  ;;   (defalias 'yes-or-no-p 'my-yes-or-mumble-p)

(fset 'yes-or-no-p 'y-or-n-p)
;; (defalias 'yes-or-no-p 'y-or-n-p)




(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)

    (defun display-code-line-counts (ov)
      (when (eq 'code (overlay-get ov 'hs))
        (overlay-put ov 'help-echo
                     (buffer-substring (overlay-start ov)
                                       (overlay-end ov)))))
    (setq hs-set-up-overlay 'display-code-line-counts)

<% if ! has_variable?('portable_config') then -%>
(server-start)
(add-to-list 'load-path "<%= @homedir %>/emacs/lib")
(require 'autoinsert)
(require 'color-theme-sanityinc-solarized)
(require 'flymake-puppet)
(require 'perltidy)
(require 'puppet-mode)
(require 'magit)
(require 'saveplace)
(require 'uniquify)
(require 'zencoding-mode)
(require 'cisco-router-mode)
(require 'vcl-mode)

;; use ibuffer by default
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(defalias 'perl-mode 'sepia-mode)
(require 'sepia)
(add-hook 'puppet-mode-hook         'hs-minor-mode)
(add-hook 'puppet-mode-hook (lambda () (flymake-puppet-load)))


;; remove trailing whitespace xcept on some "special" paths
(defun auto-whitespace-remove ()
  ;; haproxy needs spaces in some edge cases
  (if (string-match "haproxy" buffer-file-name) nil (delete-trailing-whitespace))
)
(add-hook 'before-save-hook 'auto-whitespace-remove)

;; remove trailing whitespace on save
;;(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq-default major-mode 'conf-mode)
(global-set-key [(control x) (k)] 'kill-this-buffer) ;; kill buffer without questions

;; ssh file editing thru tramp: /remotehost:file (/method:user/@host:filename)
(setq tramp-default-method "ssh")

;; vcs support
(setq
 vc-annotate-background nil
 vc-follow-symlinks t)

;; auto GPG
(epa-file-enable)
(setq custom-file "~/.emacs-custom.el.gpg")
(load custom-file 'noerror)
;; twitter
(setq-default save-place t)
(auto-insert-mode)  ;;; Adds hook to find-files-hook
(setq auto-insert-directory "<%= @homedir %>/emacs/autoinsert") ;;; Or use custom, *NOTE* Trailing slash important
(setq auto-insert-query nil) ;;; If you don't want to be prompted before insertion
(define-auto-insert "puppet.*\.pp$" "init.pp")
(define-auto-insert "puppet.*\.erb" "puppet.erb")
(define-auto-insert "puppet.*\.init" "puppet.erb")
(define-auto-insert "puppet.*\.pl" "perl.erb")
(define-auto-insert "puppet.*\.sh" "sh.erb")

;;(setq confirm-kill-emacs 'yes-or-no-p) ;; confirm emacs exit


;; file cache

(eval-after-load
    "filecache"
  '(progn
     (message "Loading file cache...")
;;     (file-cache-add-directory-list load-path)
;;     (file-cache-add-directory "~/")
;;     (file-cache-add-file-list (list "~/foo/bar" "~/baz/bar"))
))

(add-to-list 'auto-mode-alist '("\\.\\([pP][pP]\\)\\'" . puppet-mode))
(add-to-list 'auto-mode-alist '("\\.\\([vV][cC][lL]\\)\\'" . vcl-mode))
(add-to-list 'auto-mode-alist '(".*/hiera.*\\.\\(gpg\\)\\'" . yaml-mode))
(global-linum-mode 1)  ;; show line numbers in marigin, need newer emacs than centos 5 one
(global-hl-line-mode 1) ;; highlight current line - looks ugly on emacs21 coz no 256 color support on centos

;; default printing program:
(setq lpr-command "gtklp")


(tabbar-mode)
(dolist (func '(tabbar-mode tabbar-forward-tab tabbar-forward-group tabbar-backward-tab tabbar-backward-group))
   (autoload func "tabbar" "Tabs at the top of buffers and easy control-tab navigation")
)

(defmacro defun-prefix-alt (name on-no-prefix on-prefix &optional do-always)
   `(defun ,name (arg)
      (interactive "P")
      ,do-always
      (if (equal nil arg)
  ,on-no-prefix
        ,on-prefix))
)

(defun-prefix-alt shk-tabbar-next (tabbar-forward-tab) (tabbar-forward-group) (tabbar-mode 1))
(defun-prefix-alt shk-tabbar-prev (tabbar-backward-tab) (tabbar-backward-group) (tabbar-mode 1))

;; C-S-<tab> ;; C-S-<win>-<tab>
(global-set-key (kbd "<C-S-iso-lefttab>") 'tabbar-forward-tab)
(global-set-key (kbd "<C-S-s-iso-lefttab>") 'tabbar-backward-tab)
;; C-x C-<left> ;; C-x C-<right>
(global-set-key (kbd "C-x C-<right>") 'tabbar-forward-group)
(global-set-key (kbd "C-x C-<left>") 'tabbar-backward-group)

;; org-mode config
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(require 'twittering-mode)
(setq twittering-use-master-password t)
(setq twittering-icon-mode t)                ; Show icons
(setq twittering-timer-interval 300)


(setq
 org-log-done t
 org-deadline-warning-days 7
 org-fontify-emphasized-text t
 org-fontify-done-headline t
 org-use-fast-todo-selection t
 org-track-ordered-property-with-tag t
 org-enforce-todo-dependencies t
 org-combined-agenda-icalendar-file "~/emacs/org/cal.ics"
;; org-icalendar-include-bbdb-anniversaries t
 org-icalendar-include-todo t
;; org-icalendar-store-UID t
 org-icalendar-use-deadline (quote (event-if-todo todo-due))
 org-icalendar-use-scheduled (quote (event-if-todo todo-start))
 org-mobile-force-id-on-agenda-items nil
 org-agenda-category-icon-alist
 '(("[Ee]macs" "/usr/share/icons/hicolor/16x16/apps/emacs.png" nil nil :ascent center)
   ("Debian" "~/emacs/icons/debian.png" nil nil :ascent center)
   ("Financial" "~/emacs/icons/money.png" nil nil :ascent center)
   ("Org.*" "~/emacs/icons/org.png" nil nil :ascent center)
   ("Medical" "~/emacs/icons/medical.png" nil nil :ascent center)
   ("Music" "~/emacs/icons/music.png" nil nil :ascent center)
   ("Projects" "~/emacs/icons/gnus.png" nil nil :ascent center)
   ("Meeting" "~/emacs/icons/trip.png" nil nil :ascent center)
   ("RItLater" "~/emacs/icons/logbook.png" nil nil :ascent center)
   ("Reading" "~/emacs/icons/book.png" nil nil :ascent center)
   ("Tasks" "~/emacs/icons/rect-scarlet.png" nil nil :ascent center)
   (".*" '(space . (:width (16)))))
)
;;(setq org-agenda-include-all-todo nil)

(setf org-todo-keyword-faces '(
                 ("NEXT" . (:foreground "orange" :weight bold))
                 ("REOPEN" . (:foreground "yellow" :weight bold))
                 ("TODO" . (:foreground "green" :weight bold))
                 ("CANCELLED" . (:foreground "red" :weight bold))
                 ("DONE" . (:foreground "dark grey" ))
                 ("WAIT" . (:foreground "light sky blue" :weight bold))
                 ("QUEUE" . (:foreground "slate blue" :weight bold))
                 ("DOWNLOAD" . (:foreground "slate blue" :weight bold))
                 ("READING" . (:foreground "forest green" :weight bold))
                 ("WATCH" . (:foreground "forest green" :weight bold))
                 ("FINISHED" . (:foreground "light sky blue" :weight bold))
))
(defun my-org-archive-done-tasks ()
  (interactive)
  (org-map-entries 'org-archive-subtree "/DONE" 'file))
<% end -%>

(setq display-time-day-and-date t
  display-time-24hr-format t)
(display-time)
(iswitchb-mode) ;; better buffer switching
(defun iswitchb-local-keys ()
    (mapc (lambda (K)
        (let* ((key (car K)) (fun (cdr K)))
            (define-key iswitchb-mode-map (edmacro-parse-keys key) fun)))
                '(("<right>" . iswitchb-next-match)
                ("<left>"  . iswitchb-prev-match)
                ("<up>"    . ignore             )
                ("<down>"  . ignore             ))))
(add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)

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
 version-control t)       ; use versioned backups
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(enable-recursive-minibuffers t)
 '(c-basic-offset 4)
 '(c-indent-comments-syntactically-p t)
 '(c-set-style "K&R")
 '(case-fold-search t)
 '(cperl-auto-newline nil)
 '(cperl-autoindent-on-semi t)
 '(cperl-electric-backspace-untabify t)
 '(cperl-indent-level 4)
 '(cperl-close-paren-offset -4)
 '(cperl-continued-statement-offset 4)
 '(cperl-indent-parens-as-block t)
 '(cperl-tab-always-indent t)
 '(cperl-merge-trailing-else nil) ;; this makes newline after }, so else not '} else {'
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
 '(setq-default indent-tabs-mode)
 '(standard-indent 4)
 '(tab-width 4)
 '(puppet-comment-column 64)
 '(puppet-include-indent 4)
 '(puppet-indent-level 4)
 '(hs-isearch-open t)
<%- if ! has_variable?('portable_config') then -%>
 '(cperl-mode-hook (quote (flymake-mode)))
;; magick needed to make jabber-mode work with gmail and other jabber servers
 '(starttls-extra-arguments (quote ("--insecure")))
;; for wanderlust
 '(ssl-certificate-verification-policy 0)
 '(ssl-program-arguments (quote ("--insecure" "-p" service host)))
 '(ssl-program-name "gnutls-cli")

;; jabber mode config
 '(jabber-default-priority 100)
 '(jabber-default-status "\"...z grubsza rzecz biorąc,  ludzi można podzielić na dwie kategorie:  ailurophiles i ailurophobes -  miłośników kotów i  osoby poszkodowane przez los\"" )
 '(jabber-activity-make-strings (quote jabber-activity-make-strings-shorten))
 '(jabber-activity-shorten-minimum 20)
 '(jabber-alert-message-hooks (quote (jabber-message-beep jabber-message-echo jabber-message-scroll)))
 '(jabber-alert-presence-hooks nil)
 '(jabber-auto-reconnect t)
 '(jabber-autoaway-method (quote jabber-xprintidle-get-idle-time))
 '(jabber-autoaway-status "AFK")
 '(jabber-autoaway-priority -10)
 '(jabber-autoaway-timeout 15)
 '(jabber-backlog-days 90.0)
 '(jabber-backlog-number 1000)
 '(jabber-default-priority 10)
 '(jabber-history-enable-rotation t)
 '(jabber-history-enabled t)
 '(jabber-history-size-limit 65535)
 '(jabber-mode-line-mode t)
 '(jabber-muc-default-nicknames nil)
 '(jabber-post-connect-hooks (quote (jabber-send-current-presence jabber-muc-autojoin jabber-keepalive-start jabber-vcard-avatars-find-current jabber-autoaway-start jabber-mode-line-mode)))
 '(jabber-reconnect-delay 60)
 '(jabber-roster-show-empty-group t)
 '(jabber-roster-line-format "%c %-25n %u %-8s  %S")
 '(jabber-use-global-history nil)
 '(jabber-chat-buffer-show-avatar nil)
 '(jabber-history-dir "~/emacs/jabber-history")
 '(speedbar-frame-parameters (quote ((minibuffer) (width . 30) (border-width . 0) (menu-bar-lines . 0) (tool-bar-lines . 0) (unsplittable . t) (left-fringe . 0))))
 '(speedbar-show-unknown-files t)
;; '(uniquify-buffer-name-style (quote post-forward) nil (uniquify))
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(uniquify-min-dir-content 2)
 '(whitespace-line-column 200)
<%- end-%>
 )
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
<% if ! has_variable?('portable_config') then -%>
(defun setup-window-system-frame-colours (&rest frame)
(require 'color-theme-sanityinc-solarized)
(if window-system
    (progn
      (custom-set-faces
       '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 88 :width normal :foundry "unknown" :family "Liberation Mono"))))
       '(org-document-info ((((class color) (background light)) (:foreground "#555599"))))
       '(org-drawer ((((class color) (min-colors 88) (background light)) (:foreground "#4444aa"))))
       '(org-habit-clear-face ((((background light)) (:background "#8270f9" :foreground "black"))))
       '(org-table ((((class color) (min-colors 88) (background light)) (:foreground "#ffffff"))))
       '(jabber-activity-face ((t (:foreground "#ffaa00" :weight bold))))
       '(jabber-activity-personal-face ((t (:foreground "#aaaaff" :weight bold))))
       '(jabber-chat-prompt-foreign ((t (:foreground "#66cc55" :weight bold))))
       '(jabber-chat-prompt-local ((t (:foreground "#aaaacc" :weight bold))))
       '(jabber-chat-text-local ((t (:foreground "#aaaaff"))))
       '(jabber-roster-user-online ((t (:foreground "#5577aa" :slant normal :weight bold))))
       '(whitespace-hspace ((((class color) (background light)) (:background "#444400" :foreground "lightgray"))))
       '(whitespace-newline ((t (:foreground "lightgray" :weight bold))))
       '(whitespace-space ((((class color) (background light)) (:background "#333377" :foreground "lightgray"))))
       '(whitespace-tab ((((class color) (background light)) (:background "#551111" :foreground "lightgray"))))
      )
      (add-hook 'window-configuration-change-hook
                (lambda ()
                  (setq frame-title-format
                        (concat ;;
                         invocation-name ": "
                         (replace-regexp-in-string
                          (concat "/home/" user-login-name) "~"
                          (or buffer-file-name "%b"))
;;                        "[" system-name "]"
                         ))))
      )
  )
       (color-theme-sanityinc-solarized-dark)
)
(require 'server)
 (defadvice server-create-window-system-frame
   (after set-window-system-frame-colours ())
;;   "Set custom frame colours when creating the first frame on a display"
;;   (message "Running after frame-initialize")
   (setup-window-system-frame-colours)
;;   (tool-bar-mode -1)
 ;;  (set-frame-parameter nil 'fullboth) ;; 'fullboth - maximize; 'fullscreen - fullscreen
   (defun maximize (&optional f)
     (interactive)
     (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                            '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
     (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                            '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
   ;;(maximize)
   (global-set-key [f11] 'maximize)
   )
 (ad-activate 'server-create-window-system-frame)
 (add-hook 'after-make-frame-functions 'setup-window-system-frame-colours t)
<% end -%>
(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 4)
)

(setq auto-mode-alist (cons '("*.c" . linux-c-mode)
                            auto-mode-alist))
(setq color-theme-is-global t)
(add-to-list 'auto-mode-alist '("emacs.erb" . emacs-lisp-mode))
<%- if has_variable?('portable_config') then -%>
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))
<%- else -%>
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . sepia-mode))
(add-to-list 'interpreter-mode-alist '("perl" . sepia-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . sepia-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . sepia-mode))
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
            'cperl-mode t
            'sepia-mode t
            'ruby-mode t)
      )

;; ================ jabber mode ====================
;; ==== use libnotify/notify-send to send info on new messages
(defvar libnotify-program "/usr/bin/notify-send")

(defun notify-send (title message)
  (start-process "notify" " notify"
		 libnotify-program "--expire-time=20000" "--icon=/usr/share/icons/hicolor/128x128/apps/emacs.png" title message))

(defun libnotify-jabber-notify (from buf text proposed-alert)
  "(jabber.el hook) Notify of new Jabber chat messages via libnotify"
  (when (or jabber-message-alert-same-buffer
            (not (memq (selected-window) (get-buffer-window-list buf))))
    (if (jabber-muc-sender-p from)
        (notify-send (format "(PM) %s"
                       (jabber-jid-displayname (jabber-jid-user from)))
               (format "%s: %s" (jabber-jid-resource from) text)))
      (notify-send (format "%s" (jabber-jid-displayname from))
             text)))

(add-hook 'jabber-alert-message-hooks 'libnotify-jabber-notify)


;; random shit in testing
(global-set-key "\M- " 'hippie-expand)


<% end -%>
