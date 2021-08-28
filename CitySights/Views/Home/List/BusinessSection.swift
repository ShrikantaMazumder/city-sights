//
//  BusinessSection.swift
//  CitySights
//
//  Created by Shrikanta Mazumder on 27/8/21.
//

import SwiftUI

struct BusinessSection: View {
    var businesses: [Business]
    var title: String
    
    var body: some View {
            Section(header: BusinessSectionHeader(title: title)) {
                ForEach(businesses) { business in
                    NavigationLink(
                        destination: BusinessDetail(business: business),
                        label: {
                            BusinessRow(business: business)
                        })
                }
            }
        
    }
}
