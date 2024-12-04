//
//  ExploreView.swift
//  BookMyStay
//
//  Created by Shoumik Barman Polok on 12/11/24.
//

import SwiftUI

struct ExploreView: View {
    @State private var backgroundColor: Color = .white
    @State private var showColorPicker: Bool = false
    @State private var selectedTab: Tab = .explore

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    switch selectedTab {
                    case .explore:
                        content
                    case .favorites:
                        Text("Favorites View")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .profile:
                        Text("Profile View")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .background(backgroundColor) // Dynamic background color

                // Bottom Navigation Bar
                HStack {
                    Spacer()
                    TabButton(icon: "magnifyingglass", label: "Explore", isSelected: selectedTab == .explore) {
                        selectedTab = .explore
                    }
                    Spacer()
                    TabButton(icon: "heart.fill", label: "Favorites", isSelected: selectedTab == .favorites) {
                        selectedTab = .favorites
                    }
                    Spacer()
                    Button(action: {
                        showColorPicker = true
                    }) {
                        Image(systemName: "paintbrush")
                            .font(.title2)
                            .padding()
                            .background(Circle().fill(Color.blue))
                            .foregroundColor(.white)
                    }
                    .offset(y: -10)
                    Spacer()
                    TabButton(icon: "person.fill", label: "Profile", isSelected: selectedTab == .profile) {
                        selectedTab = .profile
                    }
                    Spacer()
                }
                .frame(height: 60)
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal)
            }
            .sheet(isPresented: $showColorPicker) {
                ColorPickerView(selectedColor: $backgroundColor)
            }
        }
    }
    
    // video onujayi etotuku

    var content: some View {
        ScrollView {
            SearchAndFilterBar()

            LazyVStack(spacing: 32) {
                ForEach(0...10, id: \.self) { listing in
                    NavigationLink(value: listing) {
                        ListingItemView()
                            .frame(height: 400)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .padding()
        }
        .navigationDestination(for: Int.self) { listing in
            //ListingDetailView()
        }
    }
}


// uporer tuku e just

enum Tab {
    case explore, favorites, profile
}

struct TabButton: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(isSelected ? .blue : .gray)
                Text(label)
                    .font(.caption)
                    .foregroundColor(isSelected ? .blue : .gray)
            }
        }
    }
}

struct ColorPickerView: View {
    @Binding var selectedColor: Color

    var body: some View {
        NavigationStack {
            VStack {
                Text("Choose Background Color")
                    .font(.headline)
                    .padding()

                ColorPicker("Select a color", selection: $selectedColor, supportsOpacity: false)
                    .padding()
                    .labelsHidden() // Hides label for a cleaner look

                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        // Dismiss the sheet
                    }
                }
            }
        }
    }
}

#Preview {
    ExploreView()
}
