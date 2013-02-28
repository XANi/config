;;; xani-iswitchb.el ---
;;
(iswitchb-mode) ;; better buffer switching

(defun iswitchb-local-keys ()
    (mapc (lambda (K)
        (let* ((key (car K)) (fun (cdr K)))
            (define-key iswitchb-mode-map (edmacro-parse-keys key) fun)))
                '(("<right>" . iswitchb-next-match)
                ("<left>"  . iswitchb-prev-match)
                ("<up>"    . ignore             )
                ("<down>"  . ignore             ))))
(add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)

(provide 'xani-iswitchb)
