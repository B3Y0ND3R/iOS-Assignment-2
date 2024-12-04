import Foundation
import FirebaseFirestore

class HotelViewModel: ObservableObject {
    @Published var hotels: [Hotel] = []
    @Published var selectedHotel: Hotel?

    private let db = Firestore.firestore()

    func fetchHotels() {
        db.collection("hotels").getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                print("Error fetching hotels: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }

            self?.hotels = documents.compactMap { document -> Hotel? in
                let data = document.data()
                guard let name = data["name"] as? String,
                      let location = data["location"] as? String,
                      let rating = data["rating"] as? Double,
                      let reviews = data["reviews"] as? Int,
                      let hostName = data["hostName"] as? String,
                      let guestCapacity = data["guestCapacity"] as? Int,
                      let bedrooms = data["bedrooms"] as? Int,
                      let bathrooms = data["bathrooms"] as? Int,
                      let kitchen = data["kitchen"] as? Bool,
                      let imageUrl = data["imageUrl"] as? String else {
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
