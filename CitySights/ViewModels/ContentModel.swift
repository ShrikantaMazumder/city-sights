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
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
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
        let userLocation = locations.first
        
        if userLocation != nil {
            getBusiness(category: Constants.sightsKey, location: userLocation!)
            getBusiness(category: Constants.restaurantKey, location: userLocation!)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func getBusiness(category: String, location: CLLocation) {
        // Create url
        /*
        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        let url = URL(string: urlString)
        */
        
        var urlComponents = URLComponents(string: Constants.apiUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6"),
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            // Create url request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            // Get urlSession
            let session = URLSession.shared
                    
            // Create data task
            let dataTask = session.dataTask(with: request) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        DispatchQueue.main.async {
                            // assign decoded data to published property
                            
                            switch category {
                            case Constants.sightsKey:
                                self.sights = decodedData.businesses
                            case Constants.restaurantKey:
                                self.restaurants = decodedData.businesses
                            default:
                                break
                            }
                        }
                        
                    } catch {
                        print("Failed to decode \(error.localizedDescription)")
                    }
                }
            }
                    
            // Start data task
            dataTask.resume()
        }
        
        
    }
}
