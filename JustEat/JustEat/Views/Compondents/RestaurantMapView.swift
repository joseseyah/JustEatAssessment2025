//
//  RestaurantMapView.swift
//  JustEat
//
//  Created by Joseph Hayes on 01/04/2025.
//


import SwiftUI
import MapKit

struct RestaurantMapView: View {
    let latitude: Double
    let longitude: Double
    let name: String

    var body: some View {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )

        Map(coordinateRegion: .constant(region), annotationItems: [MapPin(coordinate: coordinate, name: name)]) { pin in
            MapMarker(coordinate: pin.coordinate, tint: .red)
        }
        .frame(height: 200)
        .cornerRadius(12)
    }
}

struct MapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let name: String
}
