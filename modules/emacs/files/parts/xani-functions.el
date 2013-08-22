;;; xani-functions.el ---
;;

;; a bunch of random functions, mostly stolen from random parts of internet


(defun volatile-kill-buffer (&optional buffer)
    "Kill current buffer, even if it has been modified."
    (interactive)
    (set-buffer-modified-p nil)
    (if buffer (kill-buffer buffer) (kill-buffer))
)
(provide 'xani-functions)
