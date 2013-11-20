;;; xani-arte.el ---
;;

(setq sepia-perl5lib (list
                      (expand-file-name "~/src/puppet/modules/artegence/files/lib/perl")
                      (expand-file-name "~/src/puppet/modules/artegence/files/lib/perl-common")
                      )
)
(setq tags-table-list
           '("~/src/puppet"))

(provide 'xani-arte)
