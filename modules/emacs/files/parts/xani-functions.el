;;; xani-functions.el ---
;;

;; a bunch of random functions, mostly stolen from random parts of internet


(defun volatile-kill-buffer (&optional buffer)
    "Kill current buffer, even if it has been modified."
    (interactive)
    (set-buffer-modified-p nil)
    (if buffer (kill-buffer buffer) (kill-buffer))
)
  ;; (defun uniquify-region-lines (start end)
  ;;   "Find duplicate lines in region START to END keeping first occurrence."
  ;;   (interactive "*r")
  ;;   (save-excursion
  ;;     (let ((lines) (end (copy-marker end)))
  ;;       (goto-char start)
  ;;       (while (and (< (point) (marker-position end))
  ;;                   (not (eobp)))
  ;;         (let ((line (buffer-substring-no-properties
  ;;                      (line-beginning-position) (line-end-position))))
  ;;           (if (member line lines)
  ;;               (delete-region (point) (progn (forward-line 1) (point)))
  ;;             (push line lines)
  ;;             (forward-line 1)))))))

(defun uniq-region-lines (beg end)
  "Unique lines in region.
Called from a program, there are two arguments:
BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (not (eobp))
        (kill-line 1)
        (yank)
        (let ((next-line (point)))
          (while
              (re-search-forward
               (format "^%s" (regexp-quote (car kill-ring))) nil t)
            (replace-match "" nil nil))
          (goto-char next-line))))))

(defun uniq-buffer-lines ()
  "Remove duplicate adjacent lines in the current buffer."
  (interactive)
  (uniquify-region-lines (point-min) (point-max)))
(provide 'xani-functions)
