//
//  DirectionsView.swift
//  CitySights
//
//  Created by Shrikanta Mazumder on 29/8/21.
//

import SwiftUI

struct DirectionsView: View {
    var business: Business
    
    var body: some View {
        VStack(alignment: .leading) {
            // Business title
            HStack {
                BusinessTitle(business: business)
                Spacer()
                if let lat = business.coordinates?.latitude,
                   let long = business.coordinates?.longitude,
                   let name = business.name {
                    Link("Open in maps", destination: URL(string: "http://maps.apple.com/?ll=\(lat),\(long)&q=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!)
                }
            }
            .padding()
            
            // directions view
            DirectionsMap(business: business)
                .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}
