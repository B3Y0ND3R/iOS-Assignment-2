import SwiftUI
import FirebaseFirestore

struct HotelFormView: View {
    @State private var name: String = ""
    @State private var location: String = ""
    @State private var rating: String = "" // Keeps it as String for the input field
    @State private var reviews: String = "" // Same here for reviews
    @State private var hostName: String = ""
    @State private var guestCapacity: String = "" // String for input field
    @State private var bedrooms: String = "" // String for input field
    @State private var bathrooms: String = "" // String for input field
    @State private var kitchen: Bool = false
    @State private var imageUrl: String = ""
    @State private var errorMessage: String = ""
    @State private var showAlert = false
    @State private var navigateToListView = false

    // Firestore reference
    private let db = Firestore.firestore()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Hotel Details")) {
                    TextField("Hotel Name", text: $name)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)

                    TextField("Location", text: $location)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)

                    TextField("Rating (e.g., 4.5)", text: $rating)
                        .keyboardType(.decimalPad)

                    TextField("Number of Reviews", text: $reviews)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Host Details")) {
                    TextField("Host Name", text: $hostName)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                }

                Section(header: Text("Hotel Capacity")) {
                    TextField("Guest Capacity", text: $guestCapacity)
                        .keyboardType(.numberPad)

                    TextField("Number of Bedrooms", text: $bedrooms)
                        .keyboardType(.numberPad)

                    TextField("Number of Bathrooms", text: $bathrooms)
                        .keyboardType(.numberPad)

                    Toggle("Kitchen Available", isOn: $kitchen)
                }

                Section(header: Text("Image URL")) {
                    TextField("Image URL", text: $imageUrl)
                        .keyboardType(.URL)
                        .textInputAutocapitalization(.none)
                }

                // Save Button
                Button(action: saveHotel) {
                    Text("Save Hotel")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }

                NavigationLink(destination: HotelListView(), isActive: $navigateToListView) {
                    EmptyView()
                }
                .hidden()
            }
            .navigationTitle("Add New Hotel")
        }
    }

    private func saveHotel() {
        // Convert strings to appropriate types
        guard let rating = Double(rating),
              let reviews = Int(reviews),
              let guestCapacity = Int(guestCapacity),
              let bedrooms = Int(bedrooms),
              let bathrooms = Int(bathrooms) else {
            errorMessage = "Please enter valid numerical values for rating, reviews, capacity, bedrooms, and bathrooms."
            showAlert = true
            return
        }

        // Prepare the data for Firestore
        let hotelData: [String: Any] = [
            "name": name,
            "location": location,
            "rating": rating,
            "reviews": reviews,
            "hostName": hostName,
            "guestCapacity": guestCapacity,
            "bedrooms": bedrooms,
            "bathrooms": bathrooms,
            "kitchen": kitchen,
            "imageUrl": imageUrl
        ]

        // Save to Firestore
        db.collection("hotels").addDocument(data: hotelData) { error in
            if let error = error {
                errorMessage = "Failed to save hotel: \(error.localizedDescription)"
                showAlert = true
            } else {
                // Reset form fields
                name = ""
                location = ""
                //rating = ""
                //reviews = ""
                hostName = ""
                //guestCapacity = ""
                //bedrooms = ""
                //bathrooms = ""
                kitchen = false
                imageUrl = ""

                // Navigate to HotelListView
                navigateToListView = true
            }
        }
    }
}

#Preview {
    HotelFormView()
}
