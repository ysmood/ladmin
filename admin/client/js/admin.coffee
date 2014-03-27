
# h1 animation example
require ['/jquery.transit/jquery.transit.js'], ->
	$('#main').transit {
		marginTop: 40
		opacity: 1
	}, ->
		$('#username').focus()

$(window).keyup (e) ->
	if e.keyCode == 13
		if not $('#adduser').is ':focus'
			$('#adduser').click()

get_user_info = ->
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
		return null

	return {
		username
		password
	}

$('#adduser').click ->
	user_info = get_user_info()

	if not user_info
		return

	$.post('/adduser', user_info).done (data) ->
		switch data
			when 'ok'
				_.notify {
					info: 'user added'
					delay: 2000
					class: 'green'
				}
				host = location.host.replace /(:\d*)$/, ''
				_.msg_box {
					title: 'How to login'
					body: """
						<p>
							Use the following command to login the linux
							<pre>ssh <b style='color: #0080ff'>#{user_info.username}</b>@#{host}</pre>
						</p>
					"""
				}
			else
				_.notify {
					info: data
					delay: 2000
					class: 'red'
				}

$('#deluser').click ->
	user_info = get_user_info()

	if not user_info
		return

	$.post('/deluser', user_info).done (data) ->
		switch data
			when 'ok'
				_.notify {
					info: 'user deleted'
					delay: 2000
					class: 'green'
				}
			else
				_.notify {
					info: data
					delay: 2000
					class: 'red'
				}
