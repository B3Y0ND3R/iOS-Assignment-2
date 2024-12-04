//
//  contentViews.swift
//  BookMyStay
//
//  Created by Shoumik Barman Polok on 30/11/24.
//

import SwiftUI

struct contentViews: View {
    @StateObject private var viewModel = HotelViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.hotels) { hotel in
                NavigationLink(
                    destination: ListingDetailView(viewModel: viewModel, hotelId: hotel.id)
                ) {
                    HStack {
                        AsyncImage(url: URL(string: hotel.imageUrl)) { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        VStack(alignment: .leading) {
                            Text(hotel.name)
                                .font(.headline)
                            Text(hotel.location)
                                .font(.subheadline)
                            Text("Rating: \(hotel.rating, specifier: "%.1f") (\(hotel.reviews) reviews)")
                                .font(.caption)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchHotels()
            }
            .navigationTitle("Hotels")
        }
    }
}
