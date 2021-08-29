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
    @Binding var selectedBusiness: Business?
    
    
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
        mapView.delegate = context.coordinator
        
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
    
    // MARK: Coordinator class
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var map: BusinessMap
        
        
        init(map: BusinessMap) {
            self.map = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // if the annotation is the user blue dot, return nil
            if annotation is MKUserLocation {
                return nil
            }
            // check if there is reusable annotation view first
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationBusinessId)
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationBusinessId)
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                // got reusable one
                annotationView?.annotation = annotation
            }
            // return
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            // user tapped on the annotation view
            
            // Get the business object that the annotation represents
            
            // loop through businesses and find the match
            for business in map.model.restaurants + map.model.sights {
                if view.annotation?.title == business.name {
                    map.selectedBusiness = business
                    return
                }
            }
        }
    }
}
