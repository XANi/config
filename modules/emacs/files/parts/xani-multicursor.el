;;; xani-multicursor.el ---
;;
;; https://github.com/magnars/multiple-cursors.el
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-M->") 'mc/mark-all-like-this)
(global-set-key (kbd "C-M-<") 'mc/insert-numbers)
(global-set-key (kbd "C-M-+") 'mc/sort-regions)
(provide 'xani-multicursor)
