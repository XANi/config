;;; install-packages.el ---

(setq package-archives '(
    ("ELPA" . "http://tromey.com/elpa/")
    ("gnu" . "http://elpa.gnu.org/packages/")
    ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)
(package-refresh-contents)

<% @emacs_packages.each do |package| %>
(when (not (require '<%= package %> nil t))
  (package-install '<%= package %>)
)

<% end %>