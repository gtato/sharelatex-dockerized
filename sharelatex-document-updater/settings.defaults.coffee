Path = require('path')
http = require('http')
http.globalAgent.maxSockets = 300

module.exports =
	internal:
		documentupdater:
			host: '0.0.0.0'
			port: 3003

	apis:
		web:
			url: process.env["SHARELATEX_WEB_URL"] or 'http://web:3000'
			user: "sharelatex"
			pass: "password"
		trackchanges:
			url: process.env["SHARELATEX_TRACK_CHANGES_URL"] or 'http://track-changes:3015'
		project_history:
			enabled: process.env.SHARELATEX_ENABLE_PROJECT_HISTORY == 'true'
			url: "http://localhost:3054"

	redis:
		realtime:
			host: process.env["SHARELATEX_REDIS_HOST"] or 'redis'
			port: process.env["SHARELATEX_REDIS_PORT"] or "6379"
			password:""
			key_schema:
				pendingUpdates: ({doc_id}) -> "PendingUpdates:#{doc_id}"
			# cluster: [{
			# 	port: "7000"
			# 	host: "localhost"
			# }]
			# key_schema:
			# 	pendingUpdates: ({doc_id}) -> "PendingUpdates:{#{doc_id}}"
		documentupdater:
			host: process.env["SHARELATEX_REDIS_HOST"] or 'redis'
			port: process.env["SHARELATEX_REDIS_PORT"] or "6379"
			password: ""
			key_schema:
				blockingKey: ({doc_id}) -> "Blocking:#{doc_id}"
				docLines: ({doc_id}) -> "doclines:#{doc_id}"
				docOps: ({doc_id}) -> "DocOps:#{doc_id}"
				docVersion: ({doc_id}) -> "DocVersion:#{doc_id}"
				docHash: ({doc_id}) -> "DocHash:#{doc_id}"
				projectKey: ({doc_id}) -> "ProjectId:#{doc_id}"
				docsInProject: ({project_id}) -> "DocsIn:#{project_id}"
				ranges: ({doc_id}) -> "Ranges:#{doc_id}"
				pathname: ({doc_id}) -> "Pathname:#{doc_id}"
				projectState: ({project_id}) -> "ProjectState:#{project_id}"
				unflushedTime: ({doc_id}) -> "UnflushedTime:#{doc_id}"
			# cluster: [{
			# 	port: "7000"
			# 	host: "localhost"
			# }]
			# key_schema:
			# 	blockingKey: ({doc_id}) -> "Blocking:{#{doc_id}}"
			# 	docLines: ({doc_id}) -> "doclines:{#{doc_id}}"
			# 	docOps: ({doc_id}) -> "DocOps:{#{doc_id}}"
			# 	docVersion: ({doc_id}) -> "DocVersion:{#{doc_id}}"
			# 	docHash: ({doc_id}) -> "DocHash:{#{doc_id}}"
			# 	projectKey: ({doc_id}) -> "ProjectId:{#{doc_id}}"
			# 	docsInProject: ({project_id}) -> "DocsIn:{#{project_id}}"
			# 	ranges: ({doc_id}) -> "Ranges:{#{doc_id}}"
			# 	projectState: ({project_id}) -> "ProjectState:{#{project_id}}"
		history:
			host: process.env["SHARELATEX_REDIS_HOST"] or 'redis'
			port: process.env["SHARELATEX_REDIS_PORT"] or "6379"
			password:""
			key_schema:
				uncompressedHistoryOps: ({doc_id}) -> "UncompressedHistoryOps:#{doc_id}"
				docsWithHistoryOps: ({project_id}) -> "DocsWithHistoryOps:#{project_id}"

		project_history:
			key_schema:
				projectHistoryOps: ({project_id}) -> "ProjectHistory:Ops:#{project_id}"
			# cluster: [{
			# 	port: "7000"
			# 	host: "localhost"
			# }]
			# key_schema:
			# 	uncompressedHistoryOps: ({doc_id}) -> "UncompressedHistoryOps:{#{doc_id}}"
			# 	docsWithHistoryOps: ({project_id}) -> "DocsWithHistoryOps:{#{project_id}}"
		lock:
			host: process.env["SHARELATEX_REDIS_HOST"] or 'redis'
			port: process.env["SHARELATEX_REDIS_PORT"] or "6379"
			password:""
			key_schema:
				blockingKey: ({doc_id}) -> "Blocking:#{doc_id}"
			# cluster: [{
			# 	port: "7000"
			# 	host: "localhost"
			# }]
			# key_schema:
			# 	blockingKey: ({doc_id}) -> "Blocking:{#{doc_id}}"
	
	max_doc_length: 2 * 1024 * 1024 # 2mb

	mongo:
		url: 'mongodb://127.0.0.1/sharelatex'