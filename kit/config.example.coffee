NB.conf = {

	port: 8013

	enable_socket_io: false

	auto_reload_page: true

	modules: {
		'NB.Database': './sys/modules/database'
		'NB.Storage': './sys/modules/storage'
		'NB.Api': './sys/modules/api'
	}

	db_filename: 'var/NB.db'

	load_langs: ['en', 'cn']

	current_lang: ['cn']

	mode: 'development'

}

NB.conf.client_conf = {

	enable_socket_io: NB.conf.enable_socket_io
	auto_reload_page: NB.conf.auto_reload_page
	current_lang: NB.conf.current_lang
	load_langs: NB.conf.load_langs
	mode: NB.conf.mode

}
