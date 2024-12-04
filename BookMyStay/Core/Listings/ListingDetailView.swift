import SwiftUI

struct ListingDetailView: View {
    @ObservedObject var viewModel: HotelViewModel
    var hotelId: String
    
    var body: some View {
        ScrollView {
            if let hotel = viewModel.selectedHotel {
                // Hotel Image
                AsyncImage(url: URL(string: hotel.imageUrl)) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 320)
                
                // Hotel Information
                VStack(alignment: .leading, spacing: 8) {
                    Text(hotel.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 2) {
                            Image(systemName: "star.fill")
                            Text("\(hotel.rating, specifier: "%.2f")")
                            Text(" - ")
                            Text("\(hotel.reviews) Reviews")
                                .underline()
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(.black)
                        
                        Text(hotel.location)
                    }
                    .font(.caption)
                }
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                
                // Host and Details
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(hotel.name) Hosted By \(hotel.hostName)")
                            .font(.headline)
                            .frame(width: 250, alignment: .leading)
                        
                        HStack(spacing: 2) {
                            Text("\(hotel.guestCapacity) guest -")
                            Text("\(hotel.bedrooms) bedrooms -")
                            Text("\(hotel.bathrooms) bathrooms -")
                            Text(hotel.kitchen ? "1 kitchen" : "No kitchen")
                        }
                        .font(.caption)
                    }
                    .frame(width: 300, alignment: .leading)
                    
                    Spacer()
                    
                    // Placeholder for Host Image
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 64, height: 64)
                }
                .padding()
                
                Divider()
                
                // Feature Details (e.g., Superhost)
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 12) {
                        Image(systemName: "star.circle.fill")
                        
                        VStack(alignment: .leading, spacing: 1) {
                            Text("Superhost")
                                .font(.footnote)
                                .fontWeight(.semibold)
                            
                            Text("Superhosts are experienced, highly rated hosts who have been trusted by millions of guests.")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .padding(.horizontal)
            } else {
                ProgressView("Loading...")
            }
        }
        .onAppear {
            viewModel.fetchHotels()
            viewModel.selectedHotel = viewModel.hotels.first { $0.id == hotelId }
        }
    }
}
