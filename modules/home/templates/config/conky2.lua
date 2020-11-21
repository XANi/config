conky.config = {
-- <%= @puppet_header %>
-- <%=  __FILE__.gsub(/.*?modules\//,'puppet://modules/') %>
	alignment = 'top_right',
	xinerama_head = 2,

	gap_x = 650,
	gap_y = 50,
--maximum_width 600

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

-- purple
	color4 = '#aca6f4',



	color5 = '#6666cc',
	color6 = '#66cc66',


-- reddish
	color7 = '#ff5533',


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

};

conky.text = [[
${execpi 300 /home/xani/bin/gcalcli.sh calm --monday}
]];
