//
//  ContentView.swift
//  JustEat
//
//  Created by Joseph Hayes on 31/03/2025.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            FoodSlotMachineView()
                .tabItem {
                    Label("Machine", systemImage: "gamecontroller")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }.accentColor(.white)
    }
}

#Preview {
  ContentView()
}
