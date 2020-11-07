import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("welcome") { req -> String in
        return "Welcome to vapor world"
    }
}
