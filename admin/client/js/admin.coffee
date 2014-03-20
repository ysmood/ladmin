
# h1 animation example
require ['/jquery.transit/jquery.transit.js'], ->
	$('#main').transit {
		marginTop: 40
		opacity: 1
	}, ->
		$('#username').focus()

$(window).keyup (e) ->
	if e.keyCode == 13
		if not $('#submit').is ':focus'
			$('#submit').click()

$('#submit').click ->
	username = $('#username').val()
	password = $('#password').val()

	if (not username) or
	(not password) or
	username != encodeURI(username)
		_.notify {
			info: 'invalid user name or password'
			class: 'red'
			delay: 2000
		}
		return

	$.post('/adduser', {
		username: username
		password: password
	}).done (data) ->
		switch data
			when 'ok'
				_.notify {
					info: 'user added'
					delay: 2000
					class: 'green'
				}
				_.msg_box {
					title: 'Use the following command to login the linux'
					body: "<pre>ssh <b style='color: #0080ff'>#{username}</b>@i.ysmood.org</pre>"
				}
			else
				_.notify {
					info: data
					delay: 2000
					class: 'red'
				}
