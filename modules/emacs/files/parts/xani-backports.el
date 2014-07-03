;;; xani-backports.el ---
;;


;; backport fixed mouse from 24.4 @0247f866e646be4bfe27ad9e72c744183f474ec9
(defun mouse-yank-primary (click)
  "Insert the primary selection at the position clicked on.
Move point to the end of the inserted text, and set mark at
beginning.  If `mouse-yank-at-point' is non-nil, insert at point
regardless of where you click."
  (interactive "e")
  ;; Give temporary modes such as isearch a chance to turn off.
  (run-hooks 'mouse-leave-buffer-hook)
  ;; Without this, confusing things happen upon e.g. inserting into
  ;; the middle of an active region.
  (when select-active-regions
    (let (select-active-regions)
      (deactivate-mark)))
  (or mouse-yank-at-point (mouse-set-point click))
  (let ((primary
         (if (fboundp 'x-get-selection-value)
             (if (eq (framep (selected-frame)) 'w32)
                 ;; MS-Windows emulates PRIMARY in x-get-selection, but not
                 ;; in x-get-selection-value (the latter only accesses the
                 ;; clipboard).  So try PRIMARY first, in case they selected
                 ;; something with the mouse in the current Emacs session.
                 (or (x-get-selection 'PRIMARY)
                     (x-get-selection-value))
               ;; Else MS-DOS or X.
               ;; On X, x-get-selection-value supports more formats and
               ;; encodings, so use it in preference to x-get-selection.
               (or (x-get-selection-value)
                   (x-get-selection 'PRIMARY)))
           ;; FIXME: What about xterm-mouse-mode etc.?
           (x-get-selection 'PRIMARY))))
    (unless primary
      (error "No selection is available"))
    (push-mark (point))
    (insert-for-yank primary)))


(defun mouse-yank-secondary (click)
  "Insert the secondary selection at the position clicked on.
Move point to the end of the inserted text.
If `mouse-yank-at-point' is non-nil, insert at point
regardless of where you click."
  (interactive "e")
  ;; Give temporary modes such as isearch a chance to turn off.
  (run-hooks 'mouse-leave-buffer-hook)
  (or mouse-yank-at-point (mouse-set-point click))
  (let ((secondary (x-get-selection 'SECONDARY)))
    (if secondary
        (insert-for-yank secondary)
      (error "No secondary selection"))))


(provide 'xani-backports)
