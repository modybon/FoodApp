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
    @Published var restaurantsList : [Restaurant] = [Restaurant]()
    var filterHelper : FilterHelper
    //The location manager’s delegate informs the app when new locations arrive and when the privacy setting changes.
    
    init(filterHelper: FilterHelper) {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        self.filterHelper = filterHelper
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
        switch authorizationStatus {
        case .notDetermined:
            requestPermission()
        case .restricted , .denied:
            requestPermission()
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            fatalError()
        }
    }
    
    func preformRestaurantsSearch(){
        self.restaurantsList.removeAll()
        let searchRequest = MKLocalSearch.Request()
        print(#function,"\(self.region)")
        searchRequest.region = self.region
        searchRequest.naturalLanguageQuery = self.filterHelper.dietOptions
        let search = MKLocalSearch(request: searchRequest)
        search.start(){ [self] response, error in
            guard let response = response else{
                print(#function, "response is null \(error!)")
                return
            }
            for item in response.mapItems{
                let restaurant = Restaurant()
                restaurant.name = item.name!
                restaurant.phoneNumber = item.phoneNumber ?? "NA"
                
                let p1 = MKPlacemark(coordinate: currentLocation!.coordinate)
                let p2 = MKPlacemark(coordinate: item.placemark.coordinate)

                let request = MKDirections.Request()
                request.source = MKMapItem(placemark: p1)
                request.destination = MKMapItem(placemark: p2)
                request.transportType = .walking

                let direction = MKDirections(request: request)

                direction.calculate(){ response , error in
                    guard let route = response?.routes.first else{return}
                    restaurant.distanceFromCL = Float(route.distance) / 1000
                    print(#function, "Name: \(restaurant.name) Distance: \(restaurant.distanceFromCL), Time: \(route.expectedTravelTime / 60)")
                    restaurant.approxWalkTime = Float((route.expectedTravelTime / 60))
                }
                
                let request2 = MKDirections.Request()
                request2.source = MKMapItem(placemark: p1)
                request2.destination = MKMapItem(placemark: p2)
                request2.transportType = .walking

                let direction2 = MKDirections(request: request2)

                direction2.calculate(){ response , error in
                    guard let route = response?.routes.first else{return}
                    print(#function, "Delivery Time: \(route.expectedTravelTime / 60)")
                    restaurant.approxDeliveryTime = Float((route.expectedTravelTime / 60))
                    restaurant.deliveryFee = (0 < restaurant.distanceFromCL && restaurant.distanceFromCL < 0.5) ? 2.99 : (restaurant.distanceFromCL < 1) ? 3.99 : 4.99
                }
                restaurant.location = item.placemark.location
                if(restaurant.deliveryFee <= self.filterHelper.maxDeliveryFee){
                    self.restaurantsList.append(restaurant)
                }
            }
        }
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
            preformRestaurantsSearch()
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
            preformRestaurantsSearch()
        }
        
        
        fetchCurrentLocation(for: locations.first)
        print(#function)
    }
    
    func fetchCurrentLocation(for location: CLLocation?){
//        guard let location = location else {return}
//        print(#function, "\(location)")
//        let geoCoder = CLGeocoder()
//        geoCoder.reverseGeocodeLocation(location){ placemarks, error in
//            self.currentLocation = placemarks?.first
//        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, "\(error.localizedDescription)")
    }
    
//    func addPin(mapView: MKMapView, coordinates : CLLocationCoordinate2D){
//        let mapAnnotation = MKPointAnnotation()
//        let annotationView = MKAnnotationView()
//        annotationView.image = UIImage(systemName: "mic.fill")
//        annotationView.annotation = mapAnnotation
//        mapAnnotation.coordinate.longitude = coordinates.longitude - 0.0002123123
//        mapAnnotation.coordinate.latitude = coordinates.latitude - 0.00123123123
//        mapAnnotation.title = "Macdonalds"
//
//        mapView.addAnnotation(mapAnnotation)
        //mapView.addAnnotation(annotationView as! MKAnnotation)
//    }
}
