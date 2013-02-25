;;; xani-org-mode.el ---
;; org-mode config
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq
 org-agenda-restore-windows-after-quit t
 org-agenda-skip-deadline-if-done t
 org-agenda-skip-scheduled-if-deadline-is-shown t
 org-agenda-skip-scheduled-if-done t
 org-agenda-start-with-log-mode t
 org-agenda-window-setup (quote current-window)
 org-export-run-in-background t
 org-indirect-buffer-display (quote current-window)
 org-log-done t
 org-deadline-warning-days 7
 org-fontify-emphasized-text t
 org-fontify-done-headline t
 org-use-fast-todo-selection t
 org-track-ordered-property-with-tag t
 org-enforce-todo-dependencies t

;; org-icalendar-include-bbdb-anniversaries t
 org-icalendar-include-todo t
 org-icalendar-alarm-time 10
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
   ("Arte-new" "~/emacs/icons/appt.png" nil nil :ascent center)
   ("Meeting" "~/emacs/icons/trip.png" nil nil :ascent center)
   ("RItLater" "~/emacs/icons/logbook.png" nil nil :ascent center)
   ("Reading" "~/emacs/icons/book.png" nil nil :ascent center)
   ("Tasks" "~/emacs/icons/rect-scarlet.png" nil nil :ascent center)
   ("Arte-Support" "~/emacs/icons/important.png" nil nil :ascent center)
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

(provide 'xani-org-mode)