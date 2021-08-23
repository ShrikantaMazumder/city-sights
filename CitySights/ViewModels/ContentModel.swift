//
//  ContentModel.swift
//  CitySights
//
//  Created by Shrikanta Mazumder on 24/8/21.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        // Request permission from user
        locationManager.requestWhenInUseAuthorization()
        
        // Start geolocating the user
    }
    
    // MARK: - Location manager delegate method
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
        } else if locationManager.authorizationStatus == .denied {
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.first ?? "Location not found!")
        
        locationManager.stopUpdatingLocation()
    }
}
