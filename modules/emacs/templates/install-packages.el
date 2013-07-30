;;; install-packages.el ---

(setq package-archives '(
    ("ELPA" . "http://tromey.com/elpa/")
    ("gnu" . "http://elpa.gnu.org/packages/")
    ("melpa" . "http://melpa.milkbox.net/packages/")
    ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)
(package-refresh-contents)

(defmacro safe-wrap (fn &rest clean-up)
  `(unwind-protect
       (let (retval)
	 (condition-case ex
	     (setq retval (progn ,fn))
	   ('error
	    (message (format "Caught exception: [%s]" ex))
	    (setq retval (cons 'exception (list ex)))))
	 retval)
     ,@clean-up))


<% @emacs_packages.each do |package| %>
(message "----> <%= package %>")
(safe-wrap (
    (lambda ()
      (when (not (require '<%= package %> nil t))
	(package-install '<%= package %>)
	)
      )
    ) 
    (message "----> <%=package %>")
)

<% end %>
