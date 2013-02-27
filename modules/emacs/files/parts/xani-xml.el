;;; xani-xml.el ---
;;


(setq
 nxml-child-indent 4
 nxml-outline-child-indent 4
)

(add-to-list 'auto-mode-alist '(".*xml\\(\\|.erb\\)\\'" . nxml-mode))


(provide 'xani-xml)


