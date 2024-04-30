//
//  ContentView.swift
//  JokeApp
//
//  Created by Sidak Singh Aulakh on 30/4/2024.
//

import SwiftUI


struct ContentView: View {
    @State private var jester: Jester = Jester()
    @State private var jokeID: String = ""
    var body: some View {
        VStack {
            Spacer()
            Text(jester.currentJoke?.type.uppercased() ?? "")
                .font(.title)
                .fontWeight(.black)
            Spacer()
            Text(jester.currentJoke?.setup ?? "")
                .font(.largeTitle)
            Spacer()
            Text(jester.currentJoke?.punchline ?? "")
                .font(.largeTitle)
            Spacer()
            TextField("get Joke by ID?", text: $jokeID)
            HStack {
                Button {
                    jester.getJoke()
                } label: {
                    Text("Get Joke")
                }
                Button {
                    jester.getJokeByID(id: jokeID)
                } label: {
                    Text("Search for Joke")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
