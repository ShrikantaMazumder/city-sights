//
//  BusinessRow.swift
//  CitySights
//
//  Created by Shrikanta Mazumder on 27/8/21.
//

import SwiftUI
import UIKit

struct BusinessRow: View {
    @ObservedObject var business: Business
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // Image
                let uiImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58)
                    .cornerRadius(5.0)
                    .scaledToFit()
                
                // name and distance
                VStack(alignment:.leading) {
                    Text(business.name ?? "")
                        .bold()
                    Text(String(format: "%.1f km away", (business.distance ?? 0) / 1000))
                        .font(.caption)
                }
                
                Spacer()
                
                // review and rating
                VStack(alignment: .leading) {
                    Image("regular_\(business.rating ?? 0.0)")
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption)
                }
            }
            DashedDivider()
                .padding(.vertical)
        }
    }
}
