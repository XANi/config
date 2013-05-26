;;; xani-ibuffer.el ---
;;

;; use ibuffer by default
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
(setq ibuffer-formats (
                       quote ((mark modified read-only " "
                                    (name 40 40 :left :elide) " "
                                    (size 9 -1 :right) " "
                                    (mode 16 16 :left :elide) " "
                                    filename-and-process
                                    )
                              (mark " " (name 16 -1) " "
                                    filename)
                              )
                             )
)

(provide 'xani-ibuffer)