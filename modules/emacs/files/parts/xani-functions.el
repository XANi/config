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


(defun to-yaml ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "/usr/local/bin/meta" (current-buffer) t)))
(defun to-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "/usr/local/bin/meta --out=json" (current-buffer) t)))
(defun to-perl ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "/usr/local/bin/meta --out=dump" (current-buffer) t)))
(defun to-xml ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "/usr/local/bin/meta --out=xml" (current-buffer) t)))
(defun to-ugly-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "/usr/local/bin/meta --out=json --ugly" (current-buffer) t)))

(defun find-file-upwards (file-to-find)
  "Recursively searches each parent directory starting from the default-directory.
looking for a file with name file-to-find.  Returns the path to it
or nil if not found."
  (labels
      ((find-file-r (path)
                    (let* ((parent (file-name-directory path))
                           (possible-file (concat parent file-to-find)))
                      (cond
                       ((file-exists-p possible-file) possible-file) ; Found
                       ;; The parent of ~ is nil and the parent of / is itself.
                       ;; Thus the terminating condition for not finding the file
                       ;; accounts for both.
                       ((or (null parent) (equal parent (directory-file-name parent))) nil) ; Not found
                       (t (find-file-r (directory-file-name parent))))))) ; Continue
    (find-file-r default-directory)))
(let ((my-tags-file (find-file-upwards "TAGS")))
  (when my-tags-file
    (message "Loading tags file: %s" my-tags-file)
    (visit-tags-table my-tags-file)))

(provide 'xani-functions)
