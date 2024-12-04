//
//  ListingImage.swift
//  BookMyStay
//
//  Created by Shoumik Barman Polok on 12/11/24.
//

import SwiftUI

struct ListingImage: View {
    
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
       
        TabView{
            ForEach(images,id: \.self) { image in
                Image(image)
                    .resizable()
                    .scaledToFill()
            }
        }
       
        .tabViewStyle(.page)
        //listing details
    }
}

#Preview {
    ListingImage()
}
