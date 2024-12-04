import Foundation

struct Hotel: Identifiable {
    let id: String
    let name: String
    let location: String
    let rating: Double
    let reviews: Int
    let hostName: String
    let guestCapacity: Int
    var bedrooms: Int
    let bathrooms: Int
    let kitchen: Bool
    let imageUrl: String
}
