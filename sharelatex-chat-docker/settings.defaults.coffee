module.exports =
	internal:
		chat:
			host: "0.0.0.0"
			port: 3010
	
	apis:
		web:
			url: process.env["SHARELATEX_WEB_URL"] or 'http://sharelatex-web:3000'
			user: "sharelatex"
			pass: "password"
			
	mongo:
		url : 'mongodb://127.0.0.1/sharelatex'
