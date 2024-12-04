//
//  BookMyStayApp.swift
//  BookMyStay
//
//  Created by Shoumik Barman Polok on 8/11/24.
//

import SwiftUI
import Firebase

@main
struct BookMyStayApp: App {
    
    init () {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
           ContentView()
            //ExploreView()
            //HotelFormView()
            //ListingDetailView("MLuLc3MJ7o9PTCtaaJX5")
            //HotelListView()
            
        }
    }
}
