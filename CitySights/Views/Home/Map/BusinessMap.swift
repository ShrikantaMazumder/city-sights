//
//  BusinessMap.swift
//  CitySights
//
//  Created by Shrikanta Mazumder on 29/8/21.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    @EnvironmentObject var model: ContentModel
    
    
    var location: [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        
        for business in model.restaurants + model.sights {
            
            // check if business has lat/long
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat ?? 0, longitude: long ?? 0)
                a.title = business.name ?? ""
                annotations.append(a)
            }
            
        }
        return annotations
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        // make the user show up on the map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // remove all annotations
        uiView.removeAnnotations(uiView.annotations)
        
        // add the ones base on the business
        uiView.showAnnotations(self.location, animated: true)
        
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
}
