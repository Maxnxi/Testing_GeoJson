////
////  MainVC2.swift
////  Testing.trackCoordinate
////
////  Created by Maksim on 09.07.2021.
////
//
//
//import UIKit
//import MapKit
//import Foundation
////import MKMapKit
//
//class MainVC: UIViewController, MKMapViewDelegate {
//
//    private var mapView: MKMapView!
//    private let services = ApiRequest()
//
//    let geoJsonUrlString = "https://waadsu.com/api/russia.geo.json"
//    var geoJsonResponse:GeoJSONResponse?
//    var coordinatesArray: [[[[Double]]]]?
//    var firstCoordinates: CLLocationCoordinate2D?
//    var totalDistance: Double?
//    
//    private var polygonInfo: PolygonInfo?
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        DispatchQueue.global().async {
//            //запрос к серверу и получение данных
//            self.getDataFromServer(urlString: self.geoJsonUrlString) { data in
//                do {
//                    guard let objs = try? MKGeoJSONDecoder().decode(data) as? [MKGeoJSONFeature] else {
//                        fatalError("Error #1")
//                    }
//                    //parse data
//                    objs.forEach { (feature) in
//                        guard let geometry = feature.geometry.first,
//                              let propData = feature.properties else {
//                            return
//                        }
//                        
//                        if let polygon = geometry as? MKPolygon {
//                            let polygonInfo = try? JSONDecoder.init().decode(PolygonInfo.self, from: propData)
//                            self.mapView.addOverlay(polygon)
//                        }
//                    }
//                    
//                } catch let err {
//                    print("Error #10", err.localizedDescription)
//                }
//                
////                    //self.geoJsonResponse = geoJson
////                    var overlays = [MKOverlay]()
////                    for item in result {
////                        if let feature = item as? MKGeoJSONFeature {
////                            for geo in feature.geometry {
////                                if let polygon = geo as? MKPolygon {
////                                    overlays.append(polygon)
////                                }
////                            }
////                        }
////                    }
//
//                    DispatchQueue.main.async {
//                        //self.mapView.addOverlays(overlays)
//                        print("Overlays added to map")
//                        guard let frstCoordinates = self.firstCoordinates else {
//                            print("Fail getting first coordinates")
//                            return
//                        }
//                        self.mapView.setRegion(MKCoordinateRegion(center: frstCoordinates, latitudinalMeters: CLLocationDistance(10_000), longitudinalMeters: CLLocationDistance(10_000)), animated: true)
////                        self.mapView.reloadInputViews()
////                        self.mapView.setNeedsDisplay()
//                    }
//
//
//
//
//            }
//
//
//
//
//            //в основной поток
//            DispatchQueue.main.async {
//                //Создаю View карты
//                let rectForMap = CGRect(x: 0, y: UIScreen.main.bounds.size.height/10, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/2)
//                self.mapView = MKMapView(frame: rectForMap)
//                self.mapView.isHidden = false
//                self.mapView.isZoomEnabled = true
//                self.mapView.mapType = .standard
//
//                //distance label
//                let distanceLabel = UILabel(frame: CGRect(x: 20, y: 20, width: UIScreen.main.bounds.size.width, height: 30))
//                var distanceString = ""
//                if self.totalDistance != nil {
//                    distanceString = "Общая дистанция в  метрах: \(self.totalDistance)  "
//                } else {
//                    distanceString = "Дистанция - не определена"
//                }
//                distanceLabel.font = UIFont(name: "Avenir", size: 14)
//                distanceLabel.text = distanceString
//                self.mapView.addSubview(distanceLabel)
//                //to do constraint for label
//
//                self.mapView.delegate = self
//                self.view.addSubview(self.mapView)
//                print("mapView - добавлен на View")
//            }            // конец DispatchQueue.main.async
//            print("Loaded")
//        }        //конец DiapatchQueue.global
//
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        print("Appeared")
//    }
//
//
//    //MARK: -> функции
//    //MARK: -> запрос к серверу и получение данных
//    //запрос к серверу и получение данных
//    func getDataFromServer(urlString:String, completion: @escaping (_ data: Data) -> Void) {
//        // создаю объект URL
//        guard let url = URL(string: urlString) else {
//            print("Error #1")
//            return
//        }
//        //создаю запрос к серверу
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//
//            //проверка на ошибку
//            if err != nil {
//                print("Error #2")
//            }
//
//            //проверяю есть ли data
//            guard let dataGeoJson = data else {
//                print("Error #3")
//                return
//            }
//            print("Data downloaded from server - done: ", data)
//
////            //парсим data
////
////            guard let parsedData = try? MKGeoJSONDecoder().decode(dataGeoJson) as? [MKGeoJSONObject] else {
////                print("Error #4")
////                return
////            }
////
//////            guard let parsedData = try? JSONDecoder().decode(GeoJSONResponse.self, from: dataGeoJson) else {
//////                completion(.failure(AppError.failedToDecode))
//////                return
//////            }
////            print("Parsed Data - done ")//, parsedData)
//
//            //выводим в основной поток (перестаховка)
////            DispatchQueue.main.async {
//                completion(dataGeoJson)
////            }
//        }.resume()
//    }
//
//    //MARK: ->
//    
//    func myDecode(data: Data){
//        guard let objs = try? MKGeoJSONDecoder().decode(data) as? [MKGeoJSONFeature] else {
//            fatalError("Error #1")
//        }
//        //parse data
//        objs.forEach { (feature) in
//            guard let geometry = feature.geometry.first,
//                  let propData = feature.properties else {
//                return
//            }
//            
//            if let polygon = geometry as? MKPolygon {
//                let polygonInfo = try? JSONDecoder.init().decode(PolygonInfo.self, from: propData)
//                self.mapView.addOverlay(polygon)
//            }
//        }
//    }
//
//
//
//
//
//
//
//
//}
//
//extension MainVC {
//
//    func mapView(_ mapView: MKMapView, didAdd renderers: [MKOverlayRenderer]) {
//        print("didAdd renderers")
//
//    }
//
//    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
//        //
//    }
//
//
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
////        let polygon = overlay as! MKPolygon
////                 let renderer = MKPolygonRenderer(polygon: polygon)
////                    renderer.fillColor = UIColor.red
////                    renderer.strokeColor = UIColor.black
////                    renderer.lineWidth = 10
////                    return renderer
//        if let polygon = overlay as? MKPolygon {
//         let renderer = MKPolygonRenderer(polygon: polygon)
//            renderer.fillColor = UIColor.red
//            renderer.strokeColor = UIColor.green
//            renderer.lineWidth = 10
//
//            return renderer
//        }
//        if overlay is MKPolyline {
//            let polyline = MKPolylineRenderer(overlay: overlay)
//            polyline.strokeColor = UIColor.red
//            return polyline
//        }
//        print("smth done in rendererFor overlay")
//    return MKOverlayRenderer(overlay: overlay)
//
//    }
//}
//
//
//
//enum AppError: Error {
//    case noDataProvided
//    case failedToDecode
//    case errorTask
//    case notCorrectUrl
//    case guardError
//}
//
//struct PolygonInfo: Codable {
//    let stroke: String?
//    let strokeWidth, strokeOpacity: Int?
//    let fill: String?
//    let fillOpacity: Double?
//    let title, subtitle: String?
//}
