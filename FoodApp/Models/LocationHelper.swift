//
//  LocationViewModel.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-29.
//

import Foundation
import CoreLocation // handles location data
import MapKit
import SwiftUI

class LocationHelper: NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var authorizationStatus : CLAuthorizationStatus
    @Published var lastSeenLocation : CLLocation?
    @Published var currentLocation: CLLocation? // Current Place
    @Published var region : MKCoordinateRegion = MKCoordinateRegion()
    private let locationManager : CLLocationManager
    
    
    //The location manager’s delegate informs the app when new locations arrive and when the privacy setting changes.
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    // CLLocationManager.locationServicesEnabled() checks if location services is enabled on the phone
    func requestPermission(){
        locationManager.requestWhenInUseAuthorization() // request while the app is in use
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.lastSeenLocation = locations.first
        if(locations.last != nil){
            // you will get most recent location
            self.currentLocation = locations.last
            print(#function, "Current Location: \(self.currentLocation!)")
            //print(#function, "Last Seen Location: \(locations.first!)")
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(
                latitude: self.currentLocation?.coordinate.latitude ?? 0,
                longitude:self.currentLocation?.coordinate.longitude ?? 0),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.01,
                    longitudeDelta: 0.01) // Controls the zoom of map
            )
        }else{
            // you will get location.first: Last know location by phone
            self.lastSeenLocation = locations.first
            print(#function, "\(self.lastSeenLocation!)")
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(
                latitude: self.lastSeenLocation?.coordinate.latitude ?? 0,
                longitude:self.lastSeenLocation?.coordinate.longitude ?? 0),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.01,
                    longitudeDelta: 0.01) // Controls the zoom of map
            )
        }
        
        
        fetchCurrentLocation(for: locations.first)
        print(#function)
    }
    
    func fetchCurrentLocation(for location: CLLocation?){
        guard let location = location else {return}
        print(#function, "\(location)")
        let geoCoder = CLGeocoder()
//        geoCoder.reverseGeocodeLocation(location){ placemarks, error in
//            self.currentLocation = placemarks?.first
//        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, "\(error.localizedDescription)")
    }
    
    func addPin(mapView: MKMapView, coordinates : CLLocationCoordinate2D){
        let mapAnnotation = MKPointAnnotation()
        let annotationView = MKAnnotationView()
        annotationView.image = UIImage(systemName: "mic.fill")
        annotationView.annotation = mapAnnotation
        mapAnnotation.coordinate.longitude = coordinates.longitude - 0.0002123123
        mapAnnotation.coordinate.latitude = coordinates.latitude - 0.00123123123
        mapAnnotation.title = "Macdonalds"
        
        mapView.addAnnotation(mapAnnotation)
        //mapView.addAnnotation(annotationView as! MKAnnotation)
    }
}
