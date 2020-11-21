conky.config = {
-- <%= @puppet_header %>
-- <%=  __FILE__.gsub(/.*?puppet\//,@fqdn + ':') %>
	alignment = 'top_right',
	xinerama_head = '<%= @conky_xinerama_head || "0" %>',

<%
# dumb but dont have time to fix it now
wan_if = "eth0"
laptop = false
if @interfaces =~ /wlan0/
   wan_if = "wlan0"
   have_wifi = true
end
if @type =~ /(book|blet)/
   laptop = true
end

mounts = []
re = /^(?<dev>.+) /# on (.+) type (.+) \(/
File.open('/proc/mounts').each_line do |l|
  (dev,mount,type) = l.split(/ /)
   if type !~ /(xfs|ext|nfs)/
     next
   end
   if mount =~/\/boot/
     next
   end
   mounts.push(mount)
end

%>


	own_window = true,
	own_window_argb_visual = true,
--own_window_argb_value 254
	own_window_transparent = false,
	own_window_class = 'Conky',
	own_window_type = 'override',
--own_window_type override
	own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
	own_window_colour = '#000000',
	own_window_argb_value = 180,
	maximum_width = 500,
	draw_shades = true,
	default_shade_color = '#000000',

--own_window yes
--own_window_class Conky
--own_window_type desktop
--own_window_type dock
--own_window_hints above,sticky,skip_taskbar,skip_pager
--own_window_transparent yes

	default_color = '#7e9fc9',
	default_outline_color = 'white',
	default_shade_color = '#1b333e',

-- default bg/fg
	color0 = '#1b333e',

-- box draw
	color1 = '#7e9fc9',

-- urgent bg/fg
	color2 = '#272122',
	color3 = '#d97a35',

	color5 = '#6666cc',
	color6 = '#66cc66',

-- purple
	color4 = '#8c86e4',
--background no

	border_width = 1,
	cpu_avg_samples = 1,
	net_avg_samples = 1,
	double_buffer = true,
	draw_borders = false,
	draw_graph_borders = false,
	draw_outline = false,
	draw_shades = false,
--draw_graph_borders yes
	use_xft = true,
	font = 'Fantasque Sans Mono:size=12',
	gap_x = 40,
	gap_y = 50,
	minimum_width = 5, minimum_height = 5,
	no_buffers = true,
	out_to_console = false,
	out_to_stderr = false,
	stippled_borders = 0,
	update_interval = 1.0,
	uppercase = false,
	use_spacer = 'none',
	show_graph_scale = false,
	show_graph_range = false,
	short_units = true,
	imap = 'host user pass3',
	top_cpu_separate = true,
	<%- = 'if laptop -%>',
	update_interval_on_battery = 3,
	<%- = 'end -%>',

};

conky.text = [[
${color1}╔${color6}$nodename [$kernel/$machine] [${uptime_short}] [${color4}${acpitemp}C${color6}]
<%- if laptop -%>
${color1}╠${color}Battery: ${color4}${battery_short}${color}[${color4}${battery_time}${color}]${alignr 10}${color6}${battery_bar 8,230}
<%- end -%>
${color1}╠${color}Frequency (in GHz):$color4 $freq_g [$freq]
${color1}╠${color}RAM:$color4 $mem/$memmax - $memperc% ${color6}${alignr 10}${membar 8,230}
${color1}╠${color}Swap:$color4 $swap/$swapmax - $swapperc% ${color6}${alignr 10}${swapbar 8,230}
${color1}╚${color}CPU:$color4 $cpu% ${color6}${alignr 10}${cpubar 8,230}
${loadgraph 50,250 00ff00 0000ff -t} ${alignr} ${color} ${cpugraph 50,250 0000aa ff0000 -t}
${color}Processes:$color4 $processes  ${color}Running:$color4 $running_processes
$hr
${color1}╔${color}File systems:
<%- mounts.each do |fs| -%>
${color1}<% if mounts.last == fs %>╚<% else %>╠<% end %>${if_match ${fs_free_perc <%= fs %>} < 10}${color3}${else}${color6}${endif}<%= fs %> ${fs_used <%= fs %>}/${fs_size <%= fs %>} ${alignr 10}${fs_bar 8,180 <%= fs %>}
<%- end -%>
${color}Diskio
${color gray} sda ${color ffcc00} ${diskio_read sda} ${color6} ${diskio_write sda}
${color}${diskiograph_read sda 50,250 0000ff 00ff00 -t -f}${color} ${alignr}${diskiograph_write sda 50,250 0000ff 00ff00 -t -f}
${color} sdb ${color ffcc00} ${diskio_read sdb} ${color6} ${diskio_write sdb}
${color}${diskiograph_read sdb 50,250 cc4400 ffaa00 -t -l}${color} ${alignr}${diskiograph_write sdb 50,250 cc4400 ffaa00 -t -l}
$hr
${color}Networking: <% if have_wifi %>AP ${wireless_ap wlan0}<% end %>
${if_gw}GW: ${color6}${gw_ip} ${color}[DNS: ${color6}${nameserver}$color] ${color}on ${color4}${gw_iface}${endif}${color}
<%- if have_wifi -%>
${color}WiFi: ${color6}${wireless_essid wlan0}$color[${wireless_bitrate wlan0} ${color}ch:${color6}${wireless_channel wlan0}${color}]${alignr}${wireless_link_bar 10,100 wlan0}
<%- end -%>
Up:${color ffcc00} ${upspeed <%= wan_if %>} ${color} - Down:${color 00ffcc} ${downspeed <%= wan_if %>}
<%- if have_wifi -%>
${color4} ${upspeedgraph eth0 25,250 ffff00 ff0000 -l -t} ${color4} ${alignr}${upspeedgraph <%= wan_if %> 25,250 ffff00 ff0000 -l -t}
${color4} ${downspeedgraph eth0 25,250 0000ff 00ff00 -l -t}${color4} ${alignr}${downspeedgraph <%= wan_if %> 25,250 0000ff 00ff00 -l -t}
<%- else -%>
${color4} ${upspeedgraph <%= wan_if %> 50,250 ffff00 ff0000 -l -t} ${alignr}${color4}${downspeedgraph <%= wan_if %> 50,250 0000ff 00ff00 -l -t}
<%- end -%>
${color}$hr
${color}╔ Name              PID   CPU%   MEM% ${color}P:${color6}$running_processes${color}/$processes${alignr 10}En: ${entropy_bar 10,80}
${color}╠${if_match ${top cpu 1} > 40}${color ffaa00}${else}${color6}${endif} ${top name 1} ${top pid 1} ${top cpu 1} ${top mem 1}
${color}╠${if_match ${top cpu 2} > 40}${color ffaa00}${else}${color6}${endif} ${top name 2} ${top pid 2} ${top cpu 2} ${top mem 2}
${color}╠${if_match ${top cpu 3} > 40}${color ffaa00}${else}${color6}${endif} ${top name 3} ${top pid 3} ${top cpu 3} ${top mem 3}
${color}╠${if_match ${top cpu 4} > 40}${color ffaa00}${else}${color6}${endif} ${top name 4} ${top pid 4} ${top cpu 4} ${top mem 4}
${color}╠${if_match ${top cpu 5} > 40}${color ffaa00}${else}${color6}${endif} ${top name 5} ${top pid 5} ${top cpu 5} ${top mem 5}
${color}╚${if_match ${top cpu 6} > 40}${color ffaa00}${else}${color6}${endif} ${top name 6} ${top pid 6} ${top cpu 6} ${top mem 6}
${color}╔ Tmux windows
${execpi 3 tmux list-windows -t main -F '${color}╠${color6} #{=30:pane_title}${color ffaa00}'}
${color}╚ with ${execi 10 tmux list-clients |wc -l} clients
]];
