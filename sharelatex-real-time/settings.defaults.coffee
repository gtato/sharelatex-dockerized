module.exports =
	redis:
		realtime:
			host: process.env["SHARELATEX_REDIS_HOST"] or 'redis'
			port: process.env["SHARELATEX_REDIS_PORT"] or "6379"
			password: ""
			key_schema:
				clientsInProject: ({project_id}) -> "clients_in_project:#{project_id}"
				connectedUser: ({project_id, client_id})-> "connected_user:#{project_id}:#{client_id}"

		documentupdater:
			host: process.env["SHARELATEX_REDIS_HOST"] or 'redis'
			port: process.env["SHARELATEX_REDIS_PORT"] or "6379"
			password: ""
			key_schema:
				pendingUpdates: ({doc_id}) -> "PendingUpdates:#{doc_id}"

		websessions:
			host: process.env["SHARELATEX_REDIS_HOST"] or 'redis'
			port: process.env["SHARELATEX_REDIS_PORT"] or "6379"
			password: ""

	internal:
		realTime:
			port: 3026
			host: "0.0.0.0"
			user: "sharelatex"
			pass: "password"
			
	apis:
		web:
			url: process.env["SHARELATEX_WEB_URL"] or 'http://web:3000'
			user: "sharelatex"
			pass: "password"
		documentupdater:
			url: process.env["SHARELATEX_DOCUMENT_UPDATER_URL"] or 'http://document-updater:3003'
			
	security:
		sessionSecret: "secret-please-change"
		
	cookieName:"sharelatex.sid"
	
	max_doc_length: 2 * 1024 * 1024 # 2mb