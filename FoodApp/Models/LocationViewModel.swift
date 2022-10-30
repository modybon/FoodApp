//
//  LocationViewModel.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-29.
//

import Foundation
import CoreLocation
import MapKit

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var authorizationStatus : CLAuthorizationStatus
    @Published var lastSeenLocation : CLLocation?
    @Published var currentPlacemark: CLPlacemark?
    @Published var region : MKCoordinateRegion = MKCoordinateRegion()
    private let locationManager : CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    
    func requestPermission(){
        locationManager.requestWhenInUseAuthorization() // request while the app is in use
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.lastSeenLocation = locations.first
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(
            latitude: self.lastSeenLocation?.coordinate.latitude ?? 0,
            longitude:self.lastSeenLocation?.coordinate.longitude ?? 0),
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01) // Controls the zoom of map
        )
        fetchCurrentLocation(for: locations.first)
        print(#function)
    }
    
    func fetchCurrentLocation(for location: CLLocation?){
        guard let location = location else {return}
        print(#function, "\(location)")
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location){ placemarks, error in
            self.currentPlacemark = placemarks?.first
        }
    }
}
