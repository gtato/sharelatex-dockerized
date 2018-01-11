	grunt.registerTask 'user:create-admin', "Create a user with the given email address and make them an admin. Update in place if the user already exists. Usage: grunt user:create-admin --email joe@example.com", () ->
		done = @async()
		email = grunt.option("email")
		if !email?
			console.error "Usage: grunt user:create-admin --email joe@example.com"
			process.exit(1)

		settings = require "settings-sharelatex"
		UserRegistrationHandler = require "./app/js/Features/User/UserRegistrationHandler"
		OneTimeTokenHandler = require "./app/js/Features/Security/OneTimeTokenHandler"
		UserRegistrationHandler.registerNewUser {
			email: email
			password: require("crypto").randomBytes(32).toString("hex")
		}, (error, user) ->
			if error? and error?.message != "EmailAlreadyRegistered"
				throw error
			user.isAdmin = true
			user.save (error) ->
				throw error if error?
				ONE_WEEK = 7 * 24 * 60 * 60 # seconds
				OneTimeTokenHandler.getNewToken user._id, { expiresIn: ONE_WEEK }, (err, token)->
					return next(err) if err?
					
					console.log ""
					console.log """
						Successfully created #{email} as an admin user.
						
						Please visit the following URL to set a password for #{email} and log in:
						
							#{settings.siteUrl}/user/password/set?passwordResetToken=#{token}
						
					"""
					done()



	grunt.registerTask 'user:seed', "creates test users, Usage: grunt user:seed --nr 100 --uname user --email sharelatex.dev --password sharelatex", () ->
		done = @async()
		nr = grunt.option("nr")
		uname = grunt.option("uname")
		email = grunt.option("email")
		password = grunt.option("password")

		if !nr?
			console.error "Usage: grunt user:seed --nr 100"
			process.exit(1)
		if !uname? 
			uname = "user"
		if !email? 
			email = "sharelatex.dev"
		if !password? 
			password = "sharelatex"


		settings = require "settings-sharelatex"
		UserRegistrationHandler = require "./app/js/Features/User/UserRegistrationHandler"
		for i in [1..nr]
			u = {
				email: "#{uname}#{i}@#{email}",
				password: password,
				holdingAccount: false
			}
			UserRegistrationHandler.registerNewUser(u, (error, user)->
				if error
					console.log("failed to create user: ", error)
					process.exit(1)
				done()
			)
			


	grunt.registerTask 'user:delete', "deletes a user and all their data, Usage: grunt user:delete --email joe@example.com", () ->
		done = @async()
		email = grunt.option("email")
		if !email?
			console.error "Usage: grunt user:delete --email joe@example.com"
			process.exit(1)
		settings = require "settings-sharelatex"
		UserGetter = require "./app/js/Features/User/UserGetter"
		UserDeleter = require "./app/js/Features/User/UserDeleter"
		UserGetter.getUser email:email, (error, user) ->
			if error?
				throw error
			if !user?
				console.log("user #{email} not in database, potentially already deleted")
				return done()
			UserDeleter.deleteUser user._id, (err)->
				if err?
					throw err
				done()
