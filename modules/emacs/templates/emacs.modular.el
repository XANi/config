;; <%= @puppet_header %>
;; <%=  __FILE__.gsub(/.*?puppet\//,@fqdn + ':') %>

<% if @memorysize_mb.to_i > 1024 %>
;; gc less to work more
;; (setq gc-cons-threshold (* 10 1024 1024))
<% end %>
;; in case of fuckery break glass
;;(when (file-executable-p "/usr/bin/gpg1") (setq epg-gpg-program "/usr/bin/gpg1"))

;;(setq server-auth-dir "~/.emacs.d/server/")
(setq server-use-tcp t)
(server-start)
;; TODO test if that can be in xani-common
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)
(add-to-list 'load-path (expand-file-name "~/emacs/lib"))
(add-to-list 'load-path (expand-file-name "~/emacs/xani-lib"))
(add-to-list 'load-path (expand-file-name "~/emacs/tmplib"))


;; init pkg mgr


(setq package-archives '(
    ("ELPA" . "http://tromey.com/elpa/")
    ("gnu" . "http://elpa.gnu.org/packages/")
    ("melpa" . "http://melpa.milkbox.net/packages/")
    ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

<%- if @rainbow && @rainbow !~ /over/ -%>
;; load this before theme so it have chance to override it
(require 'xani-rainbow)
<%- end -%>

;; and set theme
(load-theme '<%= @emacs_theme %> t)

<%- if @rainbow && @rainbow =~ /over/ -%>
;; load this after theme so it will overwrite colors
(require 'xani-rainbow)
<%- end -%>

<%- if @emacs_theme =~ /purple-haze/ -%>
;; with some customisation

(custom-theme-set-variables
 'purple-haze
 '(fringe-mode 1 nil (fringe))
 '(linum-format "%4d")
)
<%- end -%>

;; smaller font with decent progreamming/pliterki
(set-face-attribute 'default nil :height 98 :family "DejaVu Sans Mono")
;; my customisations

(require 'autoinsert)
(require 'saveplace)
(require 'uniquify)
(require 'cisco-router-mode)
(add-to-list 'magic-mode-alist '("\\!RANCID-CONTENT" . cisco-router-mode) )

;;(require 'xani-ido)
(require 'xani-notify) ;; this have to be before modules using it
(require 'xani-functions)
(require 'xani-cua)
(require 'xani-c)
(require 'xani-auto-insert)
(require 'xani-undo-tree)
(require 'xani-common)
(require 'xani-iedit)
(require 'xani-iswitchb)
(require 'xani-hs-mode)
(require 'xani-tramp)
;;(require 'xani-tabbar) ;; broken
(require 'xani-buffer-move)
(require 'xani-modeline)
(require 'xani-minibuffer)
(require 'xani-minimap)

(require 'xani-multicursor)
(require 'xani-shift-text)


;; Languages
(require 'xani-go)
(require 'xani-html-mode)
(require 'xani-markdown)
(require 'xani-org-mode)
(require 'xani-perl)
(require 'xani-puppet)
(require 'xani-ruby)
(require 'xani-vc)
(require 'xani-vcl)
(require 'xani-xml)

;; Other
(require 'xani-jabber)
(require 'xani-twittering)
(require 'xani-x)
(require 'xani-ecb)
(require 'xani-develock)
(require 'xani-company)
(require 'xani-yasnippet)
(require 'xani-man)
(require 'xani-web)
(require 'xani-testing)
<%- if @deploy_arte_config -%>
(require 'xani-arte)
(require 'xani-org-mode-arte)
(require 'xani-mediawiki)
<%- else -%>
(require 'xani-org-mode-home)
;;(setq sepia-perl5lib (list (expand-file-name "~/sepia/lib")))
<%- end -%>
(require 'xani-backports)
(require 'xani-nethack)
(require 'xani-local)
(require 'haproxy-mode)
(require 'dota2-mode)

(setq custom-file "~/.emacs-custom.el.gpg")
(load custom-file 'noerror)

(load "~/emacs/secure/local.el.gpg" 'noerror)


;; save position of cursos on last edit
(setq-default save-place t)

;; scroll/toolbar off
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; for things that need other things
(require 'xani-late)


;; file cache

;; (eval-after-load
;;     "xani-late"
;;   '(progn
;;      (message "Loading file cache...")
 <% if @location == 'arte' %>
;;      (file-cache-add-directory-using-locate  (expand-file-name "~/src/puppet"))
 <% else %>
;;      (file-cache-add-directory-using-locate  (expand-file-name "~/src/my"))
 <% end %>
 ;;     (file-cache-add-directory-list load-path)
 ;;     (file-cache-add-directory "~/")
 ;;     (file-cache-add-file-list (list "~/foo/bar" "~/baz/bar"))
;; ))

(add-hook 'sgml-mode-hook 'zencoding-mode)
(add-to-list 'auto-mode-alist '("\\.\\([vV][cC][lL]\\)\\'" . vcl-mode))
(add-to-list 'auto-mode-alist '(".*/hiera.*\\.\\(gpg\\)\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '(".*/apache/.*httpd.*" . apache-mode))

(add-to-list 'auto-mode-alist '("emacs.erb" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("emacs.modular.erb" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . diff-mode))


;; this part doesn't work well when done in provide/require
(defun setup-window-system-frame-colours (&rest frame)
(if window-system
    (progn
      (custom-set-faces
       '(cperl-array-face ((((class color) (background light)) (:inherit font-lock-variable-name-face))))
       '(cperl-hash-face ((((class color) (background light)) (:inherit font-lock-variable-name-face))))
       '(cua-rectangle ((default (:inherit region)) (((class color)) nil)))
       '(develock-long-line-2 ((t (:inherit secondary-selection :underline "#000000"))))
       '(develock-lonely-parentheses ((t (:inherit secondary-selection :foreground "PaleTurquoise"))))
       '(develock-reachable-mail-address ((t (:inherit font-lock-warning-face :underline "#775500"))))
       '(develock-upper-case-tag ((t (:foreground "Snow"))))
       '(develock-whitespace-1 ((t (:background "#550000"))))
       '(develock-whitespace-2 ((t (:background "#440000"))))
       '(develock-whitespace-3 ((t (:background "#333300"))))
       '(diff-added ((t (:inherit diff-changed :background "#114411"))))
       '(diff-removed ((t (:inherit diff-changed :background "#441111"))))
       '(org-document-info ((((class color) (background light)) (:foreground "#555599"))))
       '(org-drawer ((((class color) (min-colors 88) (background light)) (:foreground "#4444aa"))))
       '(org-habit-clear-face ((((background light)) (:background "#8270f9" :foreground "black"))))
       '(org-table ((((class color) (min-colors 88) (background light)) (:foreground "#ffffff"))))
       '(tabbar-selected ((t (:inherit default))))
       '(tabbar-unselected ((t (:inherit mode-line-inactive))))
       '(tabbar-unselected-modified ((t (:inherit mode-line :weight bold))))
       '(undo-tree-visualizer-active-branch-face ((((class color) (background light)) (:foreground "#aaaaff" :weight bold))))
       '(wl-highlight-folder-few-face ((t (:inherit font-lock-builtin-face))))
       '(wl-highlight-folder-unread-face ((t (:inherit font-lock-variable-name-face))))
       '(wl-highlight-folder-zero-face ((t (:inherit font-lock-doc-face))))
       '(wl-highlight-summary-answered-face ((t (:inherit font-lock-constant-face))))
       '(wl-highlight-summary-copied-face ((t (:inherit font-lock-comment-face :foreground "cyan" :underline t))))
       '(wl-highlight-summary-new-face ((t (:inherit font-lock-builtin-face))))
       '(wl-highlight-summary-normal-face ((t (:inherit font-lock-variable-name-face))))
       '(wl-highlight-summary-thread-top-face ((t (:inherit font-lock-variable-name-face))))
       '(wl-highlight-summary-unread-face ((t (:inherit font-lock-string-face)))))
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

(require 'server)
 (defadvice server-create-window-system-frame
   (after set-window-system-frame-colours ())
;;   "Set custom frame colours when creating the first frame on a display"
   (message "Running after frame-initialize")
   (setup-window-system-frame-colours)
;;   (load-theme 'solarized-dark t)
   ;;(load-theme '<%= @emacs_theme %> t)
;;   (tool-bar-mode -1)
 ;;  (set-frame-parameter nil 'fullboth) ;; 'fullboth - maximize; 'fullscreen - fullscreen
   (custom-set-faces
    '(term-color-black ((t (:background "black" :foreground "dim gray"))))
    '(term-color-blue ((t (:background "dark blue" :foreground "royal blue"))))
    )
   (defun maximize (&optional f)
     (interactive)
     (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                            '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
     (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                            '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
   ;;(maximize)
   (global-set-key [f11] 'toggle-frame-fullscreen)
   (global-set-key [f12] 'menu-bar-mode)
   (scroll-bar-mode -1)
   (tool-bar-mode -1)
   (menu-bar-mode -1)
   )
 (ad-activate 'server-create-window-system-frame)
 ;;(add-hook 'after-make-frame-functions 'setup-window-system-frame-colours t)
;;
;; ---------------------------------------------
;;
