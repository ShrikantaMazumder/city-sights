//
//  BusinessTitle.swift
//  CitySights
//
//  Created by Shrikanta Mazumder on 29/8/21.
//

import SwiftUI

struct BusinessTitle: View {
    var business: Business
    
    var body: some View {
        VStack(alignment: .leading) {
            // Business name
            Text(business.name ?? "")
                .font(.largeTitle)
            
            // Address
            ForEach(business.location.displayAddress ?? [""], id:\.self) { address in
                Text(address)
            }
            // Rating
            Image("regular_\(business.rating ?? 0.0)")
        }
    }
}
