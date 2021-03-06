;;; xani-jabber.el ---
;;
(custom-set-variables
 '(jabber-activity-make-strings (quote jabber-activity-make-strings-shorten))
 '(jabber-activity-shorten-minimum 20)
 '(jabber-alert-info-message-hooks
   (quote
    (jabber-info-libnotify jabber-info-echo jabber-info-display)))
 '(jabber-alert-message-hooks
   (quote
    (jabber-message-libnotify jabber-message-beep jabber-message-echo jabber-message-scroll)))
 '(jabber-alert-muc-hooks
   (quote
    (jabber-muc-libnotify-personal jabber-muc-echo jabber-muc-scroll)))
 '(jabber-alert-presence-hooks nil)
 '(jabber-auto-reconnect t)
 '(jabber-libnotify-timeout 20000)
 '(jabber-libnotify-icon "emacs") ;; dunst cant handle 128x128
 ;; '(jabber-libnotify-icon "/usr/share/icons/hicolor/16x16/apps/emacs-snapshot.png") ;; dunst cant handle 128x128
 '(jabber-autoaway-method (quote jabber-xprintidle-get-idle-time))
 '(jabber-autoaway-priority -10)
 '(jabber-autoaway-status "AFK")
 '(jabber-autoaway-timeout 15)
 '(jabber-backlog-days 90.0)
 '(jabber-backlog-number 1000)
 '(jabber-chat-buffer-show-avatar nil)
 '(jabber-chat-buffer-format "*-chat-%n-*")
 '(jabber-default-priority 10)
 '(jabber-default-priority 100)
 ;; '(jabber-default-status "\"...z grubsza rzecz biorąc,  ludzi można podzielić na dwie kategorie:  ailurophiles i ailurophobes -  miłośników kotów i  osoby poszkodowane przez los\"" )
 '(jabber-default-status "\"Ghost in the Shell: The Very Original title\" http://www.imdb.com/title/tt4337072/" )
;; '(jabber-default-status "4 sextillion 722 quintillion 366 quadrillion 482 trillion 869 billion 645 million 213 thousand 696 IPs" )
 '(jabber-history-dir "~/emacs/jabber-history")
 '(jabber-history-enable-rotation t)
 '(jabber-history-enabled t)
 '(jabber-history-size-limit 1024)
 '(jabber-invalid-certificate-servers (quote ("artegence.com" "im.3dart.com")))
 '(jabber-mode-line-mode t)
 '(jabber-muc-default-nicknames nil)
 '(jabber-post-connect-hooks (quote (jabber-send-current-presence jabber-muc-autojoin jabber-keepalive-start jabber-vcard-avatars-find-current jabber-autoaway-start jabber-mode-line-mode)))
 '(jabber-reconnect-delay 60)
 '(jabber-roster-line-format "%c %-25n %u %-8s  %S")
 '(jabber-roster-show-empty-group t)
 '(jabber-use-global-history nil)
 )
(custom-set-faces
       '(jabber-activity-face ((t (:foreground "#ffaa00" :weight bold))))
       '(jabber-activity-personal-face ((t (:foreground "#aaaaff" :weight bold))))
       '(jabber-chat-prompt-foreign ((t (:foreground "#66cc55" :weight bold))))
       '(jabber-chat-prompt-local ((t (:foreground "#aaaacc" :weight bold))))
       '(jabber-chat-text-local ((t (:foreground "#aaaaff"))))
       '(jabber-roster-user-online ((t (:foreground "#5577aa" :slant normal :weight bold))))
)

;; this is supposed to make clicking url work http://www.emacswiki.org/emacs/JabberEl#toc5

(add-hook 'jabber-chat-mode-hook 'goto-address)

(provide 'xani-jabber)
