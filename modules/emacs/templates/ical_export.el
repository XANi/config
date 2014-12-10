(add-to-list 'load-path (expand-file-name "~/emacs/lib"))
(add-to-list 'load-path (expand-file-name "~/emacs/xani-lib"))
(add-to-list 'load-path (expand-file-name "~/emacs/tmplib"))
(require 'xani-org-mode)
<%- if @deploy_arte_config -%>
(require 'xani-org-mode-arte)
<%- else -%>
(require 'xani-org-mode-home)
<%- end -%>
(org-mode)
(setq
 org-agenda-default-appointment-duration 15
 )
(org-icalendar-combine-agenda-files)
