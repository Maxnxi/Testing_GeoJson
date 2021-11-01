////
////  MainVC4.swift
////  Testing.trackCoordinate
////
////  Created by Maksim on 10.07.2021.
////
//// Решение Тестового задания
//// Автор: Максим Пономарев В.
//// несмотря на отсутствие ограничения на использования стороних библиотек
//// Решил использовать стандартные стредства XCode без доп.загрузки сторонних библиотек таких как Alamofire, Promise
////
//// при использовании данных с сайта - декодировать стандартным MKGeoJSONDecoder - не получается
//// Декодирование возможно собственноручно с использованием JSONDecoder().decode(GeoJSONResponse.self, from: data)
//// но это приводит к ошибке при компоновке MKOverlay - для отрисовки стандартными методами
//// остается возможность при парсинге выдернуть только координаты (при проверке на количество - 213 фигур)
//// и самостоятельно сформировать 213 объектов (при таком варианте теряются properties) и нет гарантий, что еще не будет ошибок
//// -> !!!(возможно ошибка - в данных предоставленных на сайте "https://waadsu.com/api/russia.geo.json")
//// Проверкка гипотезы о неверном формате данных:
//// Имеем -> не работает MKGeoJSONDecoder c данными без изменений
//// Проверяю -> копирую данные с сайта в фаил "waadsuGeo"
//// отдельно вычлененняю координаты первого объекта - вставляю в стандартную модель GeoJson -> работает,
//// добавля. properties, добавляю еще 5 объектов -> работает (MKGeoJSONDecoder)
//// Вывод -> возможно в данных, представленных на сайте, - синтаксическая ошибка
//// в связи с этим исключен запрос к серверу
//// функцию запроса данных с сервера - не использую
//
//import Foundation
//import MapKit
//import UIKit
//
//class MainVC: UIViewController {
//    private var mapView: MKMapView!
//    //let geoJsonUrlString = "https://waadsu.com/api/russia.geo.json"
//    private var totalDistance = ""
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        DispatchQueue.global().async {
//            
//            //MARK: -> функция получения данных из скорректированного фаила
////ранее тут был запрос к серверу через URLSession.shared.dataTask(with: url) { (data, response, err) in ...
//            guard let urlGeoJson = Bundle.main.url(forResource: "newWaadsuPart3ver", withExtension: "json") else {
//                print("Error #40 - Unable to get geoJson")
//                return
//            }
//            var dataToParse = Data()
//            do {
//                dataToParse = try Data(contentsOf: urlGeoJson)
//                
//            } catch let err {
//                print("Error #41", err.localizedDescription)
//            }
//
//            
//            guard let decodedData = try? MKGeoJSONDecoder().decode(dataToParse) as? [MKGeoJSONObject] else {
//                print("Error #42 - Unable to decode geoJson")
//                return
//            }
//            print("decoded Data - ok - is ", decodedData)
//            
//            var overlays = [MKOverlay]()
//            for item in decodedData {
//                if let feature = item as? MKGeoJSONFeature {
//                    for geo in feature.geometry {
//                        if let polygon = geo as? MKMultiPolygon {
//                            overlays.append(polygon)
//                        }
//                    }
//                }
//            }
//            DispatchQueue.main.async {
//                self.setupMapView()
//                self.mapView.addOverlays(overlays)
//            } 
//        }
//        print("Loaded")
//    }
//    
//    func setupMapView() {
////        Создаю View карты
//        let rectForMap = CGRect(x: 0, y: UIScreen.main.bounds.size.height/10, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/2)
//        
//        self.mapView = MKMapView(frame: rectForMap)
//        self.mapView.isHidden = false
//        self.mapView.isZoomEnabled = true
//        self.mapView.mapType = .standard
//        
//        //distance label
//        let distanceLabel = UILabel(frame: CGRect(x: 20, y: 20, width: UIScreen.main.bounds.size.width, height: 30))
//        var distanceString = ""
//        if self.totalDistance != "" {
//            distanceString = "Общая дистанция в  метрах: \(self.totalDistance)  "
//        } else {
//            distanceString = "Дистанция - не определена"
//        }
//        distanceLabel.font = UIFont(name: "Avenir", size: 14)
//        distanceLabel.text = distanceString
//        self.mapView.addSubview(distanceLabel)
//        //to do constraint for label
//        
//        self.mapView.delegate = self
//        self.view.addSubview(self.mapView)
//        print("mapView - добавлен на View")
//    }
//}
//
//extension MainVC: MKMapViewDelegate {
//    
//    func mapView(_ mapView: MKMapView, didAdd renderers: [MKOverlayRenderer]) {
//            print("didAdd renderers")
//        }
//    
//        func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
//            //
//        }
//    
//        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//            if let polygon = overlay as? MKPolygon {
//             let renderer = MKPolygonRenderer(polygon: polygon)
//                renderer.fillColor = UIColor.red
//                renderer.strokeColor = UIColor.green
//                renderer.lineWidth = 10
//                return renderer
//            } else if let polyline = overlay as? MKPolyline {
//                let plline = MKPolylineRenderer(overlay: polyline)
//                plline.strokeColor = UIColor.red
//                return plline
//            } else if let multiPolygon = overlay as? MKMultiPolygon {
//                let mltPolygon = MKMultiPolygonRenderer(multiPolygon: multiPolygon)
//                mltPolygon.strokeColor = UIColor.red
//                mltPolygon.fillColor = UIColor.gray
//                print("catched Multipolygone")
//                return mltPolygon
//            }
//            print("smth done in rendererFor overlay")
//            return MKOverlayRenderer(overlay: overlay)
//    
//        }
//}
