//
//  TravelAppApp.swift
//  TravelApp
//
//  Created by Bohlale Manage on 2023/07/09.
//

import SwiftUI

@main
struct TravelAppApp: App {
    @StateObject var viewModel: TravelAppViewModel = TravelAppViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel)
        }
    }
}
