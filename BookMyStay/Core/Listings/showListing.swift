import SwiftUI
import FirebaseFirestore

struct HotelListView: View {
    @State private var hotels: [Hotel] = []
    @State private var isLoading = true

    var body: some View {
        NavigationView {
            List(hotels) { hotel in
                HStack {
                    AsyncImage(url: URL(string: hotel.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)

                    VStack(alignment: .leading) {
                        Text(hotel.name)
                            .font(.headline)
                        Text(hotel.location)
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        HStack {
                            Text("Rating: \(hotel.rating, specifier: "%.1f")")
                            Spacer()
                            Text("Reviews: \(hotel.reviews)")
                        }
                        .font(.caption)
                    }
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Hotels")
            .toolbar {
                if isLoading {
                    ProgressView()
                }
            }
        }
        .onAppear(perform: fetchHotels)
    }

    private func fetchHotels() {
        let db = Firestore.firestore()
        db.collection("hotels").getDocuments { snapshot, error in
            isLoading = false

            if let error = error {
                print("Error fetching hotels: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("No hotels found")
                return
            }

            hotels = documents.compactMap { document -> Hotel? in
                let data = document.data()
                guard
                    let name = data["name"] as? String,
                    let location = data["location"] as? String,
                    let rating = data["rating"] as? Double,
                    let reviews = data["reviews"] as? Int,
                    let hostName = data["hostName"] as? String,
                    let guestCapacity = data["guestCapacity"] as? Int,
                    let bedrooms = data["bedrooms"] as? Int,
                    let bathrooms = data["bathrooms"] as? Int,
                    let kitchen = data["kitchen"] as? Bool,
                    let imageUrl = data["imageUrl"] as? String
                else {
                    print("Missing or invalid data for hotel with ID \(document.documentID)")
                    return nil
                }

                return Hotel(
                    id: document.documentID,
                    name: name,
                    location: location,
                    rating: rating,
                    reviews: reviews,
                    hostName: hostName,
                    guestCapacity: guestCapacity,
                    bedrooms: bedrooms,
                    bathrooms: bathrooms,
                    kitchen: kitchen,
                    imageUrl: imageUrl
                )
            }
        }
    }
}

struct HotelListView_Previews: PreviewProvider {
    static var previews: some View {
        HotelListView()
    }
}
