//
//  SettingsView.swift
//  JustEat
//
//  Created by Joseph Hayes on 31/03/2025.
//


import SwiftUI

struct SettingsView: View {
    @AppStorage("userPostcode") private var userPostcode: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Address")) {
                    TextField("Enter your postcode", text: $userPostcode)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
