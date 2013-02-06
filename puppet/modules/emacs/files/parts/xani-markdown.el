;;; xani-markdown.el ---
;;

(provide 'xani-markdown)
 (add-to-list 'auto-mode-alist '("\\.\\([mM][dD]\\)\\'" . markdown-mode))
(setq
 markdown-enable-math t
 markdown-uri-types (quote ("acap" "cid" "data" "dav" "fax" "file" "ftp" "gopher" "git" "http" "https" "imap" "ldap" "mailto" "mid" "modem" "news" "nfs" "nntp" "pop" "prospero" "rtsp" "service" "sip" "ssh" "tel" "telnet" "tip" "urn" "vemmi" "wais"))
)
