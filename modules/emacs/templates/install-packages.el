;;; install-packages.el ---

(setq package-archives '(
    ("ELPA" . "http://tromey.com/elpa/")
    ("gnu" . "http://elpa.gnu.org/packages/")
    ("melpa" . "http://melpa.milkbox.net/packages/")
    ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)
(package-refresh-contents)
(setq package-list '(
<% @emacs_packages.each do |package| -%>
                     <%= package %>
<% end %>
))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (message "-----> Installing %s" package)
    (package-install package)
    )
)
