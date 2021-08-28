//
//  BusinessList.swift
//  CitySights
//
//  Created by Shrikanta Mazumder on 27/8/21.
//

import SwiftUI

struct BusinessList: View {
    @EnvironmentObject var model: ContentModel
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, pinnedViews: .sectionHeaders) {
                BusinessSection(businesses: model.restaurants, title: "Restaurants")
                
                BusinessSection(businesses: model.sights, title: "Sights")
            }
            .accentColor(.black)
        }
    }
}

