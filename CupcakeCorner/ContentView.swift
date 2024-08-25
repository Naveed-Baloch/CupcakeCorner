//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Naveed on 25/08/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var results = [Result]()
    
    var body: some View {
        NavigationStack {
            List(results, id: \.trackId) { item in
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                        } else if phase.error != nil {
                            Text("Error Loading Image")
                        } else  {
                            ProgressView()
                        }
                    }
                    .frame(width: 100, height: 100)
                    .disabled(true)
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
            }
            .navigationTitle("CupcakeCorner")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark)
            .task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        // Create URL
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            // Load Data asynchronous
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
        
    }
}


#Preview {
    ContentView()
}
