import Vapor
import Fluent
import FluentMongoDriver


// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
     
    //configure database
    try app.databases.use(.mongo(connectionString: "mongodb+srv://admin:12345@cluster0.dg45s.mongodb.net/test"), as: .mongo)
    
    app.migrations.add(User.Migration())
    app.migrations.add(UserToken.Migration())


    // register routes
    try routes(app)
}
