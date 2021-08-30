//
//  OnboardingView.swift
//  CitySights
//
//  Created by Shrikanta Mazumder on 30/8/21.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var model: ContentModel
    @State private var tabSelection = 0
    
    
    var body: some View {
        VStack {
            // Tab view
            TabView(selection: $tabSelection) {
                // First tab
                VStack(spacing: 20) {
                    Image("city2")
                        .resizable()
                        .scaledToFit()
                    Text("Welcome to city sights!")
                        .bold()
                        .font(.title)
                    Text("City sights helps you find the best of the city")
                        
                }
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .tag(0)
                
                    // second tab
                VStack(spacing: 20) {
                        Image("city1")
                            .resizable()
                            .scaledToFit()
                        Text("Ready to discover your city?")
                            .bold()
                            .font(.title)
                        Text("This is dummy text about your city. Please update this as your wish")
                            
                    }
                .padding()
                .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .tag(1)
        }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            // button
            Button {
                if tabSelection == 0 {
                    tabSelection = 1
                } else {
                    // Request user location
                    model.requestGeoLocationPermission()
                }
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    Text(tabSelection == 0 ? "Next" : "Get My Location")
                        .foregroundColor(.blue)
                        .bold()
                        .padding()
                }
            }
            .accentColor(tabSelection == 0 ? CustomColor.onboardingBlue : CustomColor.onboardingTarquoise)
            .padding()
            
            Spacer()
    }
        .background(tabSelection == 0 ? CustomColor.onboardingBlue : CustomColor.onboardingTarquoise)
        .ignoresSafeArea()
    }
}
