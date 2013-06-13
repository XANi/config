;;; xani-ibuffer.el ---
;;

;; use ibuffer by default
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
   ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
   (t (format "%8d" (buffer-size)))))
(setq ibuffer-formats (
                       quote ((mark modified read-only " "
                                    (name 40 40 :left :elide) " "
                                    (size-h 9 -1 :right) " "
                                    (mode 16 16 :left :elide) " "
                                    filename-and-process
                                    )
                              (mark " " (name 16 -1) " "
                                    filename)
                              )
                             )
)

(provide 'xani-ibuffer)