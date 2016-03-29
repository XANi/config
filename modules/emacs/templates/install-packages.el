;;; install-packages.el ---


;; gnutls needs that for domains with fucked up SSL (no intermediates)
;; you'd need to fire gnutls-cli --tofu marmalade-repo.org once to make it trusted
;; tofu means "trust on first usage"
(setq tls-program '("gnutls-cli --no-ca-verification -p %p %h"))



(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
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
