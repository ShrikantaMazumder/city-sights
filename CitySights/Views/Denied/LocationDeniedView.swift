//
//  LocationDeniedView.swift
//  CitySights
//
//  Created by Shrikanta Mazumder on 31/8/21.
//

import SwiftUI

struct LocationDeniedView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Whoops!")
                .bold()
                .font(.title)
            
            Text("This one is denied message, what they will miss for their permission denied.")
                
            
            Spacer()
            
            Button {
                // open settings
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    Text("Go to Settings")
                        .foregroundColor(CustomColor.onboardingDenied)
                        .bold()
                        .padding()
                }
            }
            .padding()
            
            Spacer()
        }
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .background(CustomColor.onboardingDenied)
        .ignoresSafeArea()
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
