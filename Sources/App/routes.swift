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

    app.on(.POST, "user","login") { req -> User in
        let user = try req.content.decode(User.self)
        print(user)
        return User(email: user.email,status: "\(user.email!)) logged in successfully!",code:100)
    }

    
}

struct User: Content {
    var email: String?
    var password: String?
    var status:String?
    var code: Int?
}
