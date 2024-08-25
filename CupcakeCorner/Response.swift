//
//  Response.swift
//  CupcakeCorner
//
//  Created by Naveed on 25/08/2024.
//

import Foundation

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct Response : Codable {
    var results: [Result]
}
