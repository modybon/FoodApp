//
//  PickUpOrderMap.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-12-03.
//

import SwiftUI
import MapKit
struct PickUpOrderMap: View {
    var currentUserPosition : Binding<CLLocation?>
    var resturantPosition : CLLocation
    var body: some View {
        PickUpOrderMapView(currentUserPosition: currentUserPosition, resturantPosition: resturantPosition)
    }
}

//struct PickUpOrderMap_Previews: PreviewProvider {
//    static var previews: some View {
//        PickUpOrderMap()
//    }
//}


struct PickUpOrderMapView : UIViewRepresentable{
    typealias UIViewType = MKMapView
    var currentUserPosition : Binding<CLLocation?>
    var resturantPosition : CLLocation
    private var mapAnnotation = MKPointAnnotation()
    private var destination = MKPointAnnotation()
    var map : MKMapView = MKMapView()
    
    init(currentUserPosition: Binding<CLLocation?>, resturantPosition: CLLocation){
        self.currentUserPosition = currentUserPosition
        self.resturantPosition = resturantPosition
    }

    func makeUIView(context: Context) -> MKMapView {
        let region : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: currentUserPosition.wrappedValue!.coordinate.latitude, longitude: currentUserPosition.wrappedValue!.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

        map.delegate = context.coordinator
        map.isZoomEnabled = true
        map.mapType = .mutedStandard
        map.region = region
        map.setRegion(region, animated: true)
        map.isZoomEnabled = true
        map.isRotateEnabled = true
        map.showsCompass = true
        
        mapAnnotation.coordinate = CLLocationCoordinate2D(latitude: currentUserPosition.wrappedValue!.coordinate.latitude, longitude: currentUserPosition.wrappedValue!.coordinate.longitude)
        destination.coordinate = CLLocationCoordinate2D(latitude: self.resturantPosition.coordinate.longitude, longitude: self.resturantPosition.coordinate.latitude)
        destination.title = "destination"
        //map.addAnnotation(mapAnnotation)
        map.userTrackingMode = .follow
        map.showsUserLocation = true
        map.addAnnotation(destination)
        let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: currentUserPosition.wrappedValue!.coordinate.latitude, longitude: currentUserPosition.wrappedValue!.coordinate.longitude))
        let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: self.resturantPosition.coordinate.longitude, longitude: self.resturantPosition.coordinate.latitude))

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .automobile

        let direction = MKDirections(request: request)

        direction.calculate(){ response , error in
            guard let route = response?.routes.first else{return}
            print(#function, "PolyLine: \(route.polyline.coordinate)")
            print(#function, "Distance: \(route.distance)")
            //self.currentOverlay = route.polyline
            map.addOverlay(route.polyline)
            map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
        return map
    }
    

    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.setRegion(uiView.region, animated: true)
    }
    func makeCoordinator() -> PickUpMapViewCoordinator {
        return PickUpMapViewCoordinator()
    }
}


class PickUpMapViewCoordinator : NSObject,MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
        renderer.lineWidth = 5
        return renderer
    }
}
