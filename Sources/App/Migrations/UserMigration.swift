//
//  File.swift
//  
//
//  Created by Rohit Saini on 12/11/20.
//
import Fluent
import Vapor

extension User {
    struct Migration: Fluent.Migration {
        var name: String { "CreateUser" }
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("users")
                .id()
                .field("name", .string, .required)
                .field("email", .string, .required)
                .field("password_hash", .string, .required)
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("users").delete()
        }
    }
}
