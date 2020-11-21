#!/bin/bash
# puppet managed template, for more info 'puppet-find-resources $filename'
# <%=  __FILE__.gsub(/.*?modules\//,'puppet://modules/') %>
export LC_ALL=en_GB.UTF8
gcalcli --conky --lineart ascii $@ | perl -p -e 's/ white}/5}/g;s/ yellow}/1}/g;s/ cyan}/6}/g;s/ red}/3}/g;s/ white}/5}/g;s/ magenta}/4}/g;'
