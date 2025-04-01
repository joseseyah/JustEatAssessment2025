//
//  ContentView.swift
//  JustEat
//
//  Created by Joseph Hayes on 31/03/2025.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RestaurantViewModel()
    var body: some View {
        TabView {
            HomeView(viewModel: viewModel)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            FoodSlotMachineView()
                .tabItem {
                    Label("Machine", systemImage: "gamecontroller")
                }

            SettingsView(viewModel: viewModel)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .tint(.white)
    }
}

#Preview {
  ContentView()
}
