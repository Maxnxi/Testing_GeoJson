////
////  ViewController.swift
////  Testing.trackCoordinate
////Аннотация:
////не работает MKGeoJSONDecoder()
////https://blog.devgenius.io/geojson-decoder-integration-e31228fdeb0
////  Created by Maksim on 08.07.2021.
////
//
//import UIKit
//import MapKit
//import Foundation
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
//    private var firstCoordinatesArray = [[Double]]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        DispatchQueue.global().async {
//            //запрос к серверу и получение данных
//            self.getDataFromServer(urlString: self.geoJsonUrlString) { result in
//                switch result{
//                case .success(let geoJson):
//                    self.geoJsonResponse = geoJson
//                    print("geoJson get - done", self.geoJsonResponse?.type)
//                    
//                    //заполнение массива координат из данных GeoJSONResponse
//                    print("self.geoJsonResponse?.features - count is - ", self.geoJsonResponse?.features.count)
//                    guard let coordinates = self.geoJsonResponse?.features.first?.geometry.coordinates else {
//                        print(AppError.guardError)
//                        return
//                    }
//                    self.coordinatesArray = coordinates
//                    print("coordinates - pushed to array - done - count", self.coordinatesArray?.count)
//                    
//                    //MARK: -> //координаты в MKPolygon
//                    
//                    var polygonsArr = [MKPolygon]()
//                    //заполняю массив polygonsArr
//                    for polygon in coordinates {
//                        let countCoordinates = polygon.count
//                        guard let exteriorPolygon = polygon.first else { return }
//                        print("===== \n exteriorPolygon.first?.first is - ", exteriorPolygon.first?.first)
//                        let frstCoordinateForArr = exteriorPolygon.first
//                        self.firstCoordinatesArray.append(frstCoordinateForArr ?? [0.0,0.0])
//                        var coordinatesArrExteriorPolygon = [CLLocationCoordinate2D]()
//                        //заполняю массив coordinatesArrExteriorPolygon
//                        for element in exteriorPolygon {
//                            guard let latitude = element.first,
//                                  let longtitude = element.last else { return }
//                            
//                            coordinatesArrExteriorPolygon.append(CLLocationCoordinate2D(latitude: latitude, longitude: longtitude))
//                        }
//                        
//                        var interiorPolygonsArr = [MKPolygon]()
//                        //заполняю массив interiorPolygons
//                        for i in 1..<polygon.count {
//                            let oneIntPolygon = polygon[i]
//                            let interCount = oneIntPolygon.count
//                            
//                            var coordinatesArr = [CLLocationCoordinate2D]()
//                            for index in oneIntPolygon {
//                                guard let latitude = index.first,
//                                      let longtitude = index.last else { return }
//                                coordinatesArr.append(CLLocationCoordinate2D(latitude: latitude, longitude: longtitude))
//                            }
//                            interiorPolygonsArr.append(MKPolygon(coordinates: coordinatesArr, count: interCount))
//                        }
//                        print("interiorPolygons", interiorPolygonsArr.count)
//                        //инициализирую MKPolygon
//                        self.firstCoordinates = coordinatesArrExteriorPolygon.first
//                        let basePolygon = MKPolygon(coordinates: coordinatesArrExteriorPolygon, count: countCoordinates, interiorPolygons: interiorPolygonsArr)
//                        polygonsArr.append(basePolygon)
//                    }
//                    //
//                
//                var overlays = [MKOverlay]()
//                    for polygon in polygonsArr {
//                        overlays.append(polygon)
//                    }
//                    
//                    
//                    print("MKOverlays count is - ", overlays.count)
//                    DispatchQueue.main.async {
//                        //self.mapView.addOverlays(overlays)
//                        self.mapView.addOverlays(overlays)
//                        print("Overlays added to map")
//                        
//                        guard let latitude = self.firstCoordinatesArray.first?.first,
//                              let longtitude = self.firstCoordinatesArray.first?.last else {
//                            print("Error midnight")
//                            return
//                        }
//                        let frstCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
////                        else {
////                            //overlays.first?.coordinate
////                    /*self.firstCoordinates*/
////                            print("Fail getting first coordinates")
////                            return
////                        }
//                        print("first point latitude is - ", frstCoordinates.latitude, self.firstCoordinatesArray.first?.first)
//                        self.mapView.setRegion(MKCoordinateRegion(center: frstCoordinates, latitudinalMeters: CLLocationDistance(100_000), longitudinalMeters: CLLocationDistance(100_000)), animated: true)
////                        self.mapView.reloadInputViews()
////                        self.mapView.setNeedsDisplay()
//                    }
//                    
//                    
//                case .failure(let err):
//                    print("Error - ", err.localizedDescription)
//                }
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
//    func getDataFromServer(urlString:String, completion: @escaping (Swift.Result<GeoJSONResponse,AppError>) -> Void) {
//        // создаю объект URL
//        guard let url = URL(string: urlString) else {
//            completion(.failure(AppError.notCorrectUrl))
//            return
//        }
//        //создаю запрос к серверу
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//            
//            //проверка на ошибку
//            if err != nil {
//                completion(.failure(AppError.errorTask))
//            }
//            
//            //проверяю есть ли data
//            guard let dataGeoJson = data else {
//                completion(.failure(AppError.noDataProvided))
//                return
//            }
//            print("Data downloaded from server - done: ", data)
//            
//            //парсим data
//            guard let parsedData = try? JSONDecoder().decode(GeoJSONResponse.self, from: dataGeoJson) else {
//                completion(.failure(AppError.failedToDecode))
//                return
//            }
//            print("Parsed Data - done ")//, parsedData)
//            
//            //выводим в основной поток (перестаховка)
//            DispatchQueue.main.async {
//                completion(.success(parsedData))
//            }
//        }.resume()
//    }
//    
//    //MARK: ->
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
//
