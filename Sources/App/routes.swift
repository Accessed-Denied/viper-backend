import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.on(.GET, "welcome",":team") { req -> String in
        guard let team = req.parameters.get("team") else{
            return "Error in team"
        }
        return "Welcome \(team) to vapor world"
    }

    //REGISTER
    app.post("users") { req -> EventLoopFuture<User> in
        try User.Create.validate(content: req)
        let create = try req.content.decode(User.Create.self)
        guard create.password == create.confirmPassword else {
            throw Abort(.badRequest, reason: "Passwords did not match")
        }
        let user = try User(
            name: create.name,
            email: create.email,
            passwordHash: Bcrypt.hash(create.password)
        )
        return user.save(on: req.db)
            .map { user }
    }
    
    
    //LOGIN
    let passwordProtected = app.grouped(User.authenticator())
    passwordProtected.post("login") { req -> EventLoopFuture<UserToken> in
        let user = try req.auth.require(User.self)
        let token = try user.generateToken()
        return token.save(on: req.db)
            .map { token }
    }
    
    //Authenticated User
    let tokenProtected = app.grouped(UserToken.authenticator())
    tokenProtected.get("me") { req -> User in
        try req.auth.require(User.self)
    }
}

