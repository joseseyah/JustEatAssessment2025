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
    let logoURL: String?
    let address: Address?

    struct Rating: Decodable {
        let starRating: Double?
        let count: Int?
    }

    struct Address: Decodable{
        let city: String
        let firstLine: String
        let postalCode: String
        let location: Location?

        struct Location: Decodable{
            let coordinates: [Double]

        }
    }

    struct Cuisine: Decodable {
        let name: String
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case rating
        case cuisines
        case logoURL = "logoUrl"
        case address
    }
}
