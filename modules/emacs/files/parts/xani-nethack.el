;;; xani-nethack.el ---
;;


 (add-hook 'nethack-map-mode-hook
         (lambda ()
           (define-key nh-map-mode-map (kbd "<left>") 'nethack-command-west)
           (define-key nh-map-mode-map (kbd "<up>") 'nethack-command-north)
           (define-key nh-map-mode-map (kbd "<down>") 'nethack-command-south)
           (define-key nh-map-mode-map (kbd "<right>") 'nethack-command-east)
           (define-key nh-map-mode-map (kbd "<home>") 'nethack-command-northwest)
           (define-key nh-map-mode-map (kbd "<prior>") 'nethack-command-northeast)
           (define-key nh-map-mode-map (kbd "<end>") 'nethack-command-southwest)
           (define-key nh-map-mode-map (kbd "<next>") 'nethack-command-southeast)
           ))
(provide 'xani-nethack)
