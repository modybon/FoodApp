//
//  CustomMapView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-11-04.
//

import SwiftUI
import MapKit

struct CustomMapView: View {
    @EnvironmentObject var locationHelper : LocationHelper
    @EnvironmentObject var restaurantHelper : RestaurantHelper
    var body: some View {
        if(self.locationHelper.currentLocation != nil){
            MyMapView()
                .environmentObject(locationHelper)
                .environmentObject(restaurantHelper)
        }else{
            Text("No Location")
        }
    }
}

//struct CustomMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomMapView()
//    }
//}

struct MyMapView : UIViewRepresentable{
    typealias UIViewType = MKMapView
    @EnvironmentObject var locationHelper : LocationHelper
    @EnvironmentObject var restaurantHelper : RestaurantHelper
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let sourceCodinates : CLLocationCoordinate2D
        let region : MKCoordinateRegion
        if(self.locationHelper.currentLocation != nil){
            sourceCodinates = self.locationHelper.currentLocation!.coordinate
        }else{
            sourceCodinates = CLLocationCoordinate2D(latitude: 43.6452, longitude: -79.282639423)
        }
        region = MKCoordinateRegion(center: sourceCodinates,
                                    span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        )
        uiView.mapType = .mutedStandard
        uiView.region = region
        uiView.showsUserLocation = true
        uiView.isZoomEnabled = true
        uiView.showsCompass = true
                
        let searchRequest = MKLocalSearch.Request()
        searchRequest.region = region
        searchRequest.naturalLanguageQuery = "food"
        let search = MKLocalSearch(request: searchRequest)
        search.start(){ response, error in
            guard let response = response else{
                print(#function, "response is null \(error)")
                return
            }
            for item in response.mapItems{
                let mapAnnotation = MKPointAnnotation()
                let annotationView = MKAnnotationView()
                annotationView.image = UIImage(systemName: "mic.fill")
                annotationView.annotation = mapAnnotation
                mapAnnotation.coordinate.longitude = item.placemark.coordinate.longitude
                mapAnnotation.coordinate.latitude = item.placemark.coordinate.latitude
                mapAnnotation.title = item.name
                uiView.addAnnotation(mapAnnotation)
                print("\(item.name): \nUrl:\(item.url)\nPhone Number: \(item.phoneNumber)")
            }
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        if(self.locationHelper.currentLocation != nil){
            return MapViewCoordinator(currentLocation: self.$locationHelper.currentLocation,currentRestaurantAnnotation: self.$restaurantHelper.currentRestaurantAnnotation , currentRestaurantMapItem: $restaurantHelper.currentRestaurantMapItem)
        }else{
            return MapViewCoordinator(currentLocation: self.$locationHelper.lastSeenLocation, currentRestaurantAnnotation: self.$restaurantHelper.currentRestaurantAnnotation, currentRestaurantMapItem: $restaurantHelper.currentRestaurantMapItem)
        }
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let sourceCodinates : CLLocationCoordinate2D
        let region : MKCoordinateRegion
        if(self.locationHelper.currentLocation != nil){
            sourceCodinates = self.locationHelper.currentLocation!.coordinate
        }else{
            sourceCodinates = CLLocationCoordinate2D(latitude: 43.6452, longitude: -79.282639423)
        }
        region = MKCoordinateRegion(center: sourceCodinates, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        
        let map = MKMapView()
        map.delegate = context.coordinator
        map.mapType = .mutedStandard
        map.region = region
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
        map.isZoomEnabled = true
        map.isRotateEnabled = true
        map.showsCompass = true
                
        let searchRequest = MKLocalSearch.Request()
        searchRequest.region = region
        searchRequest.naturalLanguageQuery = "food"
        let search = MKLocalSearch(request: searchRequest)
        search.start(){ response, error in
            guard let response = response else{
                print(#function, "response is null \(error)")
                return
            }
            for item in response.mapItems{
                let mapAnnotation = MKPointAnnotation()
                let annotationView = MKAnnotationView()
                annotationView.image = UIImage(systemName: "cloud.fill")
                annotationView.setSelected(true, animated: true)
                annotationView.annotation = mapAnnotation
                mapAnnotation.coordinate.longitude = item.placemark.coordinate.longitude
                mapAnnotation.coordinate.latitude = item.placemark.coordinate.latitude
                mapAnnotation.title = item.name
                map.addAnnotation(mapAnnotation)
            
                print("\(item.name): \nUrl:\(item.url)\nPhone Number: \(item.phoneNumber)")
            }
        }
        return map
    }
    
    
}

class MapViewCoordinator : NSObject, MKMapViewDelegate{
    var currentLocation : Binding<CLLocation?>
    var currentOverlay : MKOverlay?
    var currentRestaurantAnnotation : Binding<MKAnnotation?>
    var currentRestaurantMapItem : Binding<MKMapItem?>
    init(currentLocation: Binding<CLLocation?>, currentRestaurantAnnotation: Binding<MKAnnotation?>, currentRestaurantMapItem : Binding<MKMapItem?>) {
        self.currentLocation = currentLocation
        self.currentRestaurantAnnotation = currentRestaurantAnnotation
        self.currentRestaurantMapItem = currentRestaurantMapItem
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
        renderer.lineWidth = 5
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Tapped Restaurant")
        if(currentOverlay != nil){
            mapView.removeOverlay(currentOverlay!)
        }
        
        //print(view.annotation?.coordinate)
        let sourceCordinate = CLLocationCoordinate2D(latitude: currentLocation.wrappedValue!.coordinate.latitude, longitude: currentLocation.wrappedValue!.coordinate.longitude)
        
        let p1 = MKPlacemark(coordinate: sourceCordinate)
        let p2 = MKPlacemark(coordinate: view.annotation!.coordinate)
        
                
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .walking
        
        self.currentRestaurantAnnotation.wrappedValue = view.annotation!
        
        //print(#function,"Current Restaurant: \(self.currentRestaurant.wrappedValue?.title! ?? "NA")")
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.region = mapView.region
        searchRequest.naturalLanguageQuery = self.currentRestaurantAnnotation.wrappedValue?.title!
        let search = MKLocalSearch(request: searchRequest)
        search.start(){ response, error in
            guard let response = response else{
                print(#function, "response is null \(error)")
                return
            }
            for item in response.mapItems{
                self.currentRestaurantMapItem.wrappedValue = item
                print("Restaurant Selected: \(item.name): \nUrl:\(item.url)\nPhone Number: \(item.phoneNumber)")
            }
        }
        
        let direction = MKDirections(request: request)
        direction.calculate(){ response , error in
            guard let route = response?.routes.first else{return}
            print(#function, "Distance: \(route.distance)")
            mapView.addAnnotations([p2])
            self.currentOverlay = route.polyline
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
    }
}
