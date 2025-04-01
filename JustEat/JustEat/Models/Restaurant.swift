//
//  RestaurantResponse.swift
//  JustEat
//
//  Created by Joseph Hayes on 31/03/2025.
//


import Foundation

struct RestaurantResponse: Decodable {
    let restaurants: [Restaurant]
}

struct Restaurant: Decodable, Identifiable {
    let id: String
    let name: String
    let rating: Rating?
    let cuisines: [Cuisine]?

    struct Rating: Decodable {
        let starRating: Double?
        let count: Int?
    }

    struct Cuisine: Decodable {
        let name: String
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case rating
        case cuisines
    }
}
