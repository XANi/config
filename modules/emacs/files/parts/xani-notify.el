;;; xani-notify.el ---
;;
(defvar libnotify-program "/usr/bin/notify-send")


(defun send-desktop-notification (summary body timeout)
  "call notification-daemon method METHOD with ARGS over dbus"
  (setq body (replace-regexp-in-string "&" "&amp;" body))
  (setq body (replace-regexp-in-string "<" "&lt;" body))
  (setq body (replace-regexp-in-string ">" "&gt;" body))
  (setq body (replace-regexp-in-string
              "http\\(\\|s\\)://\\(.*?\\)\\(\s\\|$\\)"
              "<a href=\"http\\1://\\2\\3\">\\2</a>\\3"
              body)
  )
  (dbus-call-method
    :session                        ; use the session (not system) bus
    "org.freedesktop.Notifications" ; service name
    "/org/freedesktop/Notifications"   ; path name
    "org.freedesktop.Notifications" "Notify" ; Method
    "emacs"
    0
    "/usr/share/icons/hicolor/128x128/apps/emacs.png" ; icon
    summary
    body
    '(:array)
    '(:array :signature "{sv}")
    ':int32 timeout)
)

(defun notify-send (title message)
;  (start-process "notify" " notify"
;  libnotify-program "--expire-time=20000" "--icon=/usr/share/icons/hicolor/128x128/apps/emacs.png" title message)
(send-desktop-notification title message 20000)
)


(defun libnotify-jabber-notify (from buf text proposed-alert)
  "(jabber.el hook) Notify of new Jabber chat messages via libnotify"
  (when (or jabber-message-alert-same-buffer
            (not (memq (selected-window) (get-buffer-window-list buf))))
    (if (jabber-muc-sender-p from)
        (notify-send (format "(PM) %s"
                       (jabber-jid-displayname (jabber-jid-user from)))
               (format "%s: %s" (jabber-jid-resource from) text)))
      (notify-send (format "%s" (jabber-jid-displayname from))
             text))
)

(provide 'xani-notify)
