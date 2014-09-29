;;; xani-arte.el ---
;;

(setq sepia-perl5lib (list
                      (expand-file-name "~/src/puppet/modules/artegence/files/lib/perl")
                      (expand-file-name "~/src/puppet/modules/artegence/files/lib/perl-common")
                      )
)
(setq tags-table-list
           '("~/src/puppet"))

(setq
 display-time-24hr-format t
 display-time-day-and-date nil
 display-time-format "" ;; no time, only mail icon
 display-time-load-average-threshold 0.6
 display-time-mail-directory "/home/xani/mail/claws/INBOX"
 display-time-mail-file (quote none)
 display-time-use-mail-icon t
)

;; Bindings for r.a.t 5 scrollwheel
(global-set-key [(mouse-10)]           'next-buffer)
(global-set-key [(mouse-11)]           'previous-buffer)

(provide 'xani-arte)
