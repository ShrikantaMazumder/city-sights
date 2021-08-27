//
//  ContentView.swift
//  CitySights
//
//  Created by Shrikanta Mazumder on 24/8/21.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        // Detect the authorization
        if model.authorizationState == .notDetermined {
            // if undetermined, show onboarding
        } else if model.authorizationState == .authorizedAlways || model.authorizationState == .authorizedWhenInUse {
            // if approved, show home view
            HomeView()
        } else if model.authorizationState == .denied {
            // if denied, show denied view
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView().environmentObject(ContentModel())
    }
}
