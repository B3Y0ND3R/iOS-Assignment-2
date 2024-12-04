//
//  ListingItemView.swift
//  BookMyStay
//
//  Created by Shoumik Barman Polok on 12/11/24.
//

import SwiftUI

struct ListingItemView: View {
    
    var images = [
        "Hotel1",
        "Hotel2",
        "Hotel3",
        "Hotel4",
        "Hotel5",
        "Hotel6",
        "Hotel7",
        
    ]
    var body: some View {
        VStack(spacing: 8){
            
            ListingImage()
                .frame(height: 320)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
            HStack(alignment:.top){
                //details
                VStack(alignment : .leading){
                    Text("Cox Bazar, Chittagong")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
                    Text("12 miles away")
                        .foregroundStyle(.gray)
                    
                    Text("Nov 3 - 10")
                        .foregroundStyle(.gray)
                    
                    HStack(spacing: 4){
                        Text("2000/-")
                            .fontWeight(.semibold)
                            .foregroundStyle(.red)
                        
                        Text("Night")
                    }
                    .foregroundStyle(.black)
                }
                //rating
                Spacer()
                
                HStack(spacing:2){
                    Image(systemName: "star.fill")
                    Text("4.96")
                        
                }
                .foregroundStyle(.black)
            }
            .font(.footnote)
        }
        .padding()
    }
}

#Preview {
    ListingItemView()
}
