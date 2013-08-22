;;; xani-functions.el ---
;;

;; a bunch of random functions, mostly stolen from random parts of internet

(defun volatile-kill-buffer ()
  "Kill current buffer unconditionally."
  (interactive)
  (let ((buffer-modified-p nil))
    (kill-buffer (current-buffer))
    )
)


(provide 'xani-functions)
