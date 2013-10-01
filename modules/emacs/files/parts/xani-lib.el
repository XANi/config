;;; xani-lib.el ---
;;
;; Some useful functions found around internet

(defun delete-duplicate-lines (beg end)
      (interactive "r")
      (let ((lines (split-string (buffer-substring beg end) "\n")))
        (delete-region beg end)
        (insert
         (mapconcat #'identity (delete-dups lines) "\n"))))

(provide 'xani-lib)
