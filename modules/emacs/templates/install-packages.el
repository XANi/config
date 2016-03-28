;;; install-packages.el ---


;; gnutls needs that for domains with fucked up SSL (no intermediates)
;; you'd need to fire gnutls-cli --tofu marmalade-repo.org once to make it trusted
;; tofu means "trust on first usage"
(setq tls-program '("gnutls-cli --tofu -p %p %h"))


;;(setq package-archives '(
;;    ("ELPA" . "http://tromey.com/elpa/")
;;   ("gnu" . "http://elpa.gnu.org/packages/")
;;    ("melpa" . "http://melpa.milkbox.net/packages/")
;;    ("marmalade" . "http://marmalade-repo.org/packages/")))
(require 'package)
(add-to-list 'package-archives
         '("marmalade" . "http://marmalade-repo.org/packages/")
         '("melpa" . "http://melpa.milkbox.net/packages/"))

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
