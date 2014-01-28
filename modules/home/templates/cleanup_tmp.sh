#!/bin/bash
# <%= @puppet_header %>
# <%=  __FILE__.gsub(/.*?puppet\//,@fqdn + ':') %>
echo "Cleaning up TMP file"
find /var/tmp/xani -xdev -mtime +60 -type f
find /var/tmp/xani -xdev -mtime +60 -type f -delete
echo "Cleaning up empty dirs"
find /var/tmp/xani -empty -type d
find /var/tmp/xani -empty -type d -delete
chown -R xani /var/tmp/xani
