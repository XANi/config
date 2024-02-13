# <%= @puppet_header %>
# <%=  __FILE__.gsub(/.*?repos/,@fqdn + ':') %>

mkdir "<%= @homedir %>/.emacs.d"
emacs -Q --script "<%= @homedir %>/emacs/install-packages.el"
cd "<%= @homedir %>/.emacs.d"
if [ -e "<%= @homedir %>/.emacs.d/.git" ] ; then
    git add .
    git commit -a -m 'automatic update'
else
    git init
    git add .
    git commit -a -m "Initial commit"
fi
