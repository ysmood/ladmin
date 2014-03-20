class YS.Admin extends NB.Module
	constructor: ->
		super

		@name = @constructor.name.toLowerCase()

		@set_static_dir(@name + '/client', '/' + @name)

		NB.app.get '/', @home
		NB.app.post '/adduser', @adduser

	home: (req, res) =>
		# Load sections.
		data = {
			title: @name
			head: @r.render('assets/ejs/head.ejs')
			foot: @r.render('assets/ejs/foot.ejs')
			css: "/#{@name}/css/#{@name}.css"
			js: "/#{@name}/js/#{@name}.js"
		}

		# Render page.
		res.send @r.render("#{@name}/client/ejs/#{@name}.ejs", data)

	adduser: (req, res) =>
		spawn = require('child_process').spawn
		p_adduser = spawn 'admin/adduser.sh', [
			req.body.username
			req.body.password
		]

		ret = ''
		p_adduser.stdout.on 'data', (data) ->
			ret += data.toString()

		p_adduser.on 'close', ->
			res.send ret
