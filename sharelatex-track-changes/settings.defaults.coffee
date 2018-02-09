Path = require('path')
TMP_DIR = Path.resolve(Path.join(__dirname, "../../", "tmp"))

module.exports =
	mongo:
		url: 'mongodb://127.0.0.1/sharelatex'  
	internal:
		trackchanges:
			port: 3015
			host: "0.0.0.0"
	apis:
		documentupdater:
			url: process.env["SHARELATEX_DOCUMENT_UPDATER_URL"] or 'http://document-updater:3003'
		web:
			url: process.env["SHARELATEX_WEB_URL"] or 'http://web:3000'
			user: "sharelatex"
			pass: "password"
	redis:
		lock:
			host: process.env["SHARELATEX_REDIS_HOST"] or 'redis'
			port: process.env["SHARELATEX_REDIS_PORT"] or "6379"
			pass: ""
			key_schema:
				historyLock: ({doc_id}) -> "HistoryLock:#{doc_id}"
				historyIndexLock: ({project_id}) -> "HistoryIndexLock:#{project_id}"
		history:
			host: process.env["SHARELATEX_REDIS_HOST"] or 'redis'
			port: process.env["SHARELATEX_REDIS_PORT"] or "6379"
			password:""
			key_schema:
				uncompressedHistoryOps: ({doc_id}) -> "UncompressedHistoryOps:#{doc_id}"
				docsWithHistoryOps: ({project_id}) -> "DocsWithHistoryOps:#{project_id}"

	trackchanges:
		continueOnError: true
		s3:
			key: ""
			secret: ""
		stores:
			doc_history: ""


	path:
		dumpFolder:   Path.join(TMP_DIR, "dumpFolder")