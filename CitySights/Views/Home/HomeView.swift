//
//  Home.swift
//  CitySights
//
//  Created by Shrikanta Mazumder on 27/8/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    
    var body: some View {
        
        NavigationView {
            if model.restaurants.count != 0 || model.sights.count != 0 {
                if isMapShowing {
                    // Show map view
                } else {
                    // List view
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "location")
                            Text("San Fransisco")
                            Spacer()
                            Text("Switch to Map view")
                        }
                        Divider()
                        
                        BusinessList()
                    }
                    .navigationBarHidden(true)
                    .padding([.horizontal, .top])
                }
                
            } else {
                ProgressView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ContentModel())
    }
}
