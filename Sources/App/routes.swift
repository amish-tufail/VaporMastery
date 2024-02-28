import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("hello", "vapor") { req async -> String in
        "Hello, VAPOR :)!!"
    }
    
    app.get("hello", ":name") { req async throws -> String in
        guard let name = req.parameters.get("name") else {
            throw Abort(.internalServerError)
        }
        return "Hello, \(name). Nice to Meet You. :)"
    }
    
    app.post("info") { req async throws -> String in
        let data = try req.content.decode(InfoData.self)
        return "Hello, \(data.name)"
    }
    
    app.post("infoResponse") { req async throws -> InfoResponse in
        let data = try req.content.decode(InfoData.self)
        return InfoResponse(response: data)
    }
}

struct InfoData: Content {
    let name: String
}

struct InfoResponse: Content {
    let response: InfoData
}
