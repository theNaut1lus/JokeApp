//
//  jester.swift
//  JokeApp
//
//  Created by Sidak Singh Aulakh on 30/4/2024.
//

import Foundation


@Observable
class Jester {
    var currentJoke: JokeClass?
    var error: String?
    var jokeURL: String = "https://joke.deno.dev"
    
    func getJoke() -> Void {
        guard let url = URL(string: jokeURL) else {
            print("ERROR: the URL is bad.")
            return
        }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let safeData = data {
//                print(safeData)
                self.parseJSON(jokeData: safeData)
            }
        }
        task.resume()
    }
    
    func parseJSON(jokeData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(JokeClass.self, from: jokeData)
            DispatchQueue.main.async {
                self.currentJoke = decodedData
            }
        } catch {
            print("Error decoding JSON")
        }
    }
    
    func getJokeByID(id: String) {
        guard let url = URL(string: jokeURL + "/" + id) else {
            print("ERROR: the URL is bad.")
            return
        }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let safeData = data {
//                print(safeData)
                self.parseJSON(jokeData: safeData)
            }
        }
        task.resume()
    }
}

struct Joke: Decodable {
    var id: Int
    var type: String
    var setup: String
    var punchline: String
}

class JokeClass: Decodable {
    var id: Int
    var type: String
    var setup: String
    var punchline: String
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.type = try container.decode(String.self, forKey: .type)
        self.setup = try container.decode(String.self, forKey: .setup)
        self.punchline = try container.decode(String.self, forKey: .punchline)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case setup
        case punchline
    }
    
    
}
