//
//  JustEatViewModel.swift
//  JustEat
//
//  Created by Joseph Hayes on 31/03/2025.
//


import Foundation
import CoreLocation


@MainActor
class RestaurantViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var errorMessage: String? = nil

    func fetchRestaurants(postcode: String, filterByCuisine cuisineFilter: String? = nil) async {
        let trimmed = postcode.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = URL(string: "https://uk.api.just-eat.io/discovery/uk/restaurants/enriched/bypostcode/\(trimmed)") else {
            self.errorMessage = "Something is invalid here"
            return
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode(RestaurantResponse.self, from: data)

            let filteredRestaurants = decoded.restaurants.lazy
                .filter { $0.isOpenNowForDelivery }
                .filter {
                    guard let cuisine = cuisineFilter else { return true }
                    return $0.cuisines?.first?.name.lowercased() == cuisine.lowercased()
                }
                .prefix(10)

            self.restaurants = Array(filteredRestaurants)

            
            self.restaurants = Array(filteredRestaurants.prefix(10))

        } catch {
            self.errorMessage = "Failed to decode response: \(error.localizedDescription)"
        }
    }

    func validatePostcode(_ postcode: String, completion: @escaping (Bool) -> Void){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(postcode){ placemarks, error in
          // some errors produced and postcode is treated as invalid
          if let _ = error {
              completion(false)
          }
          // postcode has got placemarks
          else if let placemarks = placemarks, !placemarks.isEmpty {
              completion(true)
          }
          else {
              completion(false)
        }
      }
    }
}
