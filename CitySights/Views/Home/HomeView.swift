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
    @State var selectedBusiness: Business?
    
    var body: some View {
        
        NavigationView {
            if model.restaurants.count != 0 || model.sights.count != 0 {
                if isMapShowing {
                    // Show map view
                   
                    ZStack(alignment: .top) {
                        BusinessMap(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in
                                BusinessDetail(business: business)
                        }
                        ZStack {
                            Rectangle()
                                .frame(height: 48)
                                .foregroundColor(.white)
                            HStack {
                                Image(systemName: "location")
                                Text(model.placeMark?.locality ?? "Your location")
                                Spacer()
                                Button(action: {
                                    self.isMapShowing = false
                                }, label: {
                                    Text("Switch to List view")
                                })
                            }
                            .padding()
                        }
                        .padding()
                    }
                } else {
                    // List view
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "location")
                            Text(model.placeMark?.locality ?? "Your location")
                            Spacer()
                            Button(action: {
                                self.isMapShowing = true
                            }, label: {
                                Text("Switch to Map view")
                            })
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
