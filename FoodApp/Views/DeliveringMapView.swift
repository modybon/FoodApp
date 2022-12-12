//
//  DeliveringMapView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-11-24.
//

import SwiftUI
import MapKit
struct DeliveringMapView: View {
    var currentUserPosition : Binding<CLLocation?>
    var resturantPosition : CLLocation
    @State var stepsCoordinates : [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
    var body: some View {
        MapView(stepsCoordinates: $stepsCoordinates, startPosition: currentUserPosition, endPosition: resturantPosition)
    }
}

struct MapView : UIViewRepresentable{
    typealias UIViewType = MKMapView
    private var startPosition : Binding<CLLocation?>
    private var endPosition : CLLocation
    private var mapAnnotation = MKPointAnnotation()
    private var destination = MKPointAnnotation()
    var map : MKMapView = MKMapView()
    var stepsCoordinates :  Binding<[CLLocationCoordinate2D]>
    init(stepsCoordinates: Binding<[CLLocationCoordinate2D]>,  startPosition : Binding<CLLocation?> , endPosition : CLLocation){
        self.stepsCoordinates = stepsCoordinates
        self.startPosition = startPosition
        self.endPosition = endPosition
    }

    func makeUIView(context: Context) -> MKMapView {
        let region : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: startPosition.wrappedValue!.coordinate.latitude, longitude: startPosition.wrappedValue!.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

        map.delegate = context.coordinator
        map.isZoomEnabled = true
        map.mapType = .mutedStandard
        map.region = region
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
        map.isZoomEnabled = true
        map.isRotateEnabled = true
        map.showsCompass = true

        mapAnnotation.coordinate = CLLocationCoordinate2D(latitude: endPosition.coordinate.latitude, longitude: endPosition.coordinate.longitude)
        destination.coordinate = CLLocationCoordinate2D(latitude: startPosition.wrappedValue!.coordinate.latitude, longitude: startPosition.wrappedValue!.coordinate.longitude)
        destination.title = "destination"
        map.addAnnotation(mapAnnotation)
        map.addAnnotation(destination)
        let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: endPosition.coordinate.latitude, longitude: endPosition.coordinate.longitude))
        let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: startPosition.wrappedValue!.coordinate.latitude, longitude: startPosition.wrappedValue!.coordinate.longitude))

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .automobile

        let direction = MKDirections(request: request)

        direction.calculate(){ response , error in
            guard let route = response?.routes.first else{return}
            
            print(#function, "PolyLine: \(route.polyline.coordinate)")
            for step in route.steps{
                self.stepsCoordinates.wrappedValue.append(step.polyline.coordinate)
                print(#function, "Step Coordinates: \(step.polyline.coordinate)")
                print(#function, "Step Instruction: \(step.instructions)")
            }
            print(#function, "Distance: \(route.distance)")
            //self.currentOverlay = route.polyline
            map.addOverlay(route.polyline)
            map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
        return map
    }
    
    
    func moveCar(car: MKPointAnnotation, newStep: CLLocationCoordinate2D) {
            print(#function, newStep)
            car.coordinate.latitude = newStep.latitude
            car.coordinate.longitude = newStep.longitude
            DispatchQueue.main.async {
                map.addAnnotation(car)
            }
            print("Car Moved")
        
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("Updated")
//        for step in self.stepsCoordinates.wrappedValue{
//            self.delay.start(withTimeInterval: 5.0,caller: self){
//                moveCar(car: mapAnnotation, newStep: step)
//            }
//        }
        for step in self.stepsCoordinates.wrappedValue{
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
                self.moveCar(car: mapAnnotation, newStep: step)
            }
        }

        let sourceCodinates : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.50998, longitude: -0.1337)
        let region : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: sourceCodinates.latitude, longitude: sourceCodinates.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        uiView.setRegion(region, animated: true)
    }
    func makeCoordinator() -> CustomAnnotation {
        return CustomAnnotation()
    }
}

//struct DeliveringMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeliveringMapView()
//    }
//}


class CustomAnnotation : NSObject,MKMapViewDelegate{

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
        renderer.lineWidth = 5
        return renderer
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "car"

        if (annotation is MKUserLocation){
            return nil
        }

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if(annotation.title == "destination"){
            let markerView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            //markerView.canShowCallout = true
            markerView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            let image = UIImage(systemName: "mappin")
            //markerView.glyphImage = UIImage()
            markerView.image = image
            annotationView = markerView
        }
        if(annotationView == nil){
            let markerView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            //markerView.canShowCallout = true
            markerView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            let image = UIImage(systemName: "car.fill")
            //markerView.glyphImage = UIImage()
            markerView.image = image
            annotationView = markerView
        }else{
            annotationView?.annotation = annotation
        }
        return annotationView
    }
}





//func fetchRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
//
//    let session = URLSession.shared
//
//    let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=43.466160, -79.714989&destination=43.467160,-79.714989&sensor=false&mode=driving&key=AIzaSyB_VL6NXgkRjdDiHC00ULY2u16GPwkF7bM")!
//
//    let task = session.dataTask(with: url, completionHandler: {
//        (data, response, error) in
//
//        guard error == nil else {
//            print(error!.localizedDescription)
//            return
//        }
//
//        guard let json = data else{
//            return
//        }
//
//
//
//        guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any], let jsonResponse = jsonResult else {
//            print("error in JSONSerialization")
//            return
//        }
//        print(#function, jsonResult)
////            guard let routes = jsonResponse["routes"] as? [Any] else {
////                return
////            }
////
////            guard let route = routes[0] as? [String: Any] else {
////                return
////            }
////
////            guard let overview_polyline = route["overview_polyline"] as? [String: Any] else {
////                return
////            }
////
////            guard let polyLineString = overview_polyline["points"] as? String else {
////                return
////            }
//
//        //Call this method to draw path on map
//        //self.drawPath(from: polyLineString)
//    })
//    task.resume()
//}


//
//struct MapView : UIViewRepresentable{
//
//    func makeUIView(context: Context) -> GMSMapView {
//        let camera = GMSCameraPosition.camera(withLatitude: 43.466160, longitude: -79.714989, zoom: 15)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        let car = GMSMarker()
//        car.position = CLLocationCoordinate2D(latitude: 43.466160, longitude: -79.714989)
//        car.icon = UIImage(systemName: "car.fill")
//        car.title = "Sydney"
//        car.snippet = "Australia"
//        car.map = mapView
//        let resturant = GMSMarker()
//        resturant.position = CLLocationCoordinate2D(latitude: 43.467160, longitude: -79.714989)
//        resturant.icon = UIImage(systemName: "car.fill")
//        resturant.title = "Macdonalds"
//        resturant.map = mapView
//        fetchRoute(from: car.position, to: resturant.position)
//        return mapView
//    }
//
//
//    func drawPath(from polyStr: String){
//        let path = GMSPath(fromEncodedPath: polyStr)
//        let polyline = GMSPolyline(path: path)
//        polyline.strokeWidth = 3.0
//        polyline.map = mapView // Google MapView
//    }
//
//    func updateUIView(_ uiView: GMSMapView, context: Context) {
//        let point = GMSMarker(position: CLLocationCoordinate2D(latitude: 43.466160, longitude: 43.466160))
////        point.icon = UIImage(systemName: "car.fill")
//        point.title = "Home"
//        point.snippet = "asjhduyas"
//        point.map = uiView
//    }
//    func makeCoordinator() -> () {
//        <#code#>
//    }
//}
