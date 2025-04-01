//
//  JustEatViewModel.swift
//  JustEat
//
//  Created by Joseph Hayes on 31/03/2025.
//


import Foundation

class RestaurantViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var errorMessage: String? = nil

    func fetchRestaurants(postcode: String, filterByCuisine cuisineFilter: String? = nil) {
        let trimmed = postcode.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = URL(string: "https://uk.api.just-eat.io/discovery/uk/restaurants/enriched/bypostcode/\(trimmed)") else {
            self.errorMessage = "Something is invalid here"
            return
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No data"
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(RestaurantResponse.self, from: data)
                    var filteredRestaurants = decoded.restaurants

                    if let cuisine = cuisineFilter {
                        filteredRestaurants = filteredRestaurants.filter { restaurant in
                            restaurant.cuisines?.first?.name.lowercased() == cuisine.lowercased()
                        }
                    }



                    self.restaurants = Array(filteredRestaurants.prefix(10))

                } catch {
                    self.errorMessage = "Failed to decode response: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
