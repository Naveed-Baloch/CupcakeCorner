//
//  Observable-Codable.swift
//  CupcakeCorner
//
//  Created by Naveed on 25/08/2024.
//

import Foundation
import SwiftUI
import Observation

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name", _email = "email"
    }
    
    var name = "Taylor"
    var email = "mail@g.com"
}

struct ContentView2: View {
    var body: some View {
        Button("Encode Taylor", action: encodeTaylor)
    }

    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
}


#Preview {
    ContentView2()
}
