////  Created by Maksim on 11.07.2021.
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
//// и сформировать 213 объектов (при таком варианте теряются properties) и нет гарантий, что еще не будет ошибок
//// -> !!!(возможно ошибка - в данных предоставленных на сайте "https://waadsu.com/api/russia.geo.json")
//// Проверка гипотезы о неверном формате данных:
//// Имеем -> не работает MKGeoJSONDecoder c данными без изменений
//// Проверяю -> копирую данные с сайта в фаил "waadsuGeo"
//// отдельно вычлененняю координаты первого объекта - вставляю в стандартную модель GeoJson -> работает,
//// добавляю properties, добавляю еще 5 объектов -> работает (MKGeoJSONDecoder)
//// Вывод -> возможно в данных, представленных на сайте, - синтаксическая ошибка
//// копирую полностью массив координат -> MKGeoJSONDecoder не работает -> присутствует ошибка
////
//// В данном варианте представлен ручной парсинг данных через JSONDecoder() и формирование GeoJSONResponse
//// после выдернуты координаты и добавлены в массив координат
//// из массива координат получен массив MKPolyline - 213 штук
//// MKPolylines - добавлены в массив Overlay и добавлены на mapView
//// Итог: -> Успешно нарисован маршрут - границы России, и посчитана протяженность по координатам,
//// однако согласно утверждению о наличии ошибки, в представленных данных на сайте,
//// визуально подтверждено -> лишние 4 линии -> Возможно ошибка
//
//
//import Foundation
//import MapKit
//import UIKit
//
//class MainVC: UIViewController {
//    
//    private let geoJsonUrlString = "https://waadsu.com/api/russia.geo.json" // источник данных
//    private var coordinates = [[[[Double]]]]()  //массив координат
//    private var arrayOfDistances = [Double]()   //на всякий случай
//    private var totalDistance: Double = 0.0  //Общее расстояние
//    private var mkMultiPolyline = MKMultiPolyline()
//    private var mapView: MKMapView!
//    private var polylinesArray = [MKPolyline]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        DispatchQueue.global().async{
////1.запрос данных с сервера
//            var dataFromServer = Data()
//            self.getDataFromServer(urlString: self.geoJsonUrlString) { result in
//                switch result{
//                case .success(let data):
//                    dataFromServer = data
//                    print("geoJson data get - done")
//                case .failure(let err):
//                    print("Error #52")
//        }
//                
////2.парсим data
//                guard let parsedData = try? JSONDecoder().decode(GeoJSONResponse.self, from: dataFromServer) else {
//                    fatalError("Error #53 - Failed to decode")
//                }
//                print("Parsed Data - done ", parsedData.type)
//                
////3.заполнение массива координат из данных GeoJSONResponse
//                guard let tmpCoordinates = parsedData.features.first?.geometry.coordinates else {
//                    print(AppError.failToFullArrayWithCoordinates)
//                    return
//                }
//                self.coordinates = tmpCoordinates
//                print("get coordinates - count -", self.coordinates.count)
//                
////4.получаем общую дистанцию (паралельно заполняем массив дисстанций - всех объектов)
//                guard let dstInMeters = self.getDistance(coordinatesArr: self.coordinates) else {
//                    print("Error #54 - Getting distance")
//                    return
//                }
//                self.totalDistance = dstInMeters
//                
////5.координаты в MKMultiPOLYLINE
//                //var multiPolyline = MKMultiPolyline()
//                var polylinesTmpArray = [MKPolyline]()
//                self.coordinates.forEach { commonElementCoordinates in
//                    commonElementCoordinates.forEach { coordElement in
//                        
//                        var coordinatesArrForPolyline = [CLLocationCoordinate2D]()
//                        coordElement.forEach { coordinate in
//                            let longtitudeCoor = coordinate[0]
//                            let latitudeCoord = coordinate[1]
//                            let clloc = CLLocationCoordinate2D(latitude: latitudeCoord, longitude: longtitudeCoor)
//                            coordinatesArrForPolyline.append(clloc)
//                        }
//                        let polyline = MKPolyline(coordinates: coordinatesArrForPolyline, count: coordinatesArrForPolyline.count)
//                        polylinesTmpArray.append(polyline)
//                    }
//                }
//                self.polylinesArray = polylinesTmpArray
//                self.mkMultiPolyline = MKMultiPolyline(polylinesTmpArray)
//                
////6.добавляем MapView
//                var overlays = [MKOverlay]()
//                self.polylinesArray.forEach { element in
//                    if let polyline = element as? MKPolyline {
//                        overlays.append(polyline)
//                    }
//                }
//                //в основном потоке конфигурируем MapView
//                DispatchQueue.main.async {
//                    self.setupMapView()
//                    self.mapView.addOverlays(overlays)
//                    print("mapView addOverlays - done - count: ", overlays.count )
//                }
//
//        print("Loaded")
//            }
//        }
//        //конец DispatchQueue.global().async
//    }
//}
//
//extension MainVC {
////    MARK: -> запрос к серверу и получение данных
//        //запрос к серверу и получение данных
//        func getDataFromServer(urlString:String, completion: @escaping (Swift.Result<Data,AppError>) -> Void) {
//            // создаю объект URL
//            guard let url = URL(string: urlString) else {
//                completion(.failure(AppError.notCorrectUrl))
//                return
//            }
//            //создаю запрос к серверу
//            URLSession.shared.dataTask(with: url) { (data, response, err) in
//    
//                //проверка на ошибку
//                if err != nil {
//                    completion(.failure(AppError.errorTask))
//                }
//    
//                //проверяю есть ли data
//                guard let dataGeoJson = data else {
//                    completion(.failure(AppError.noDataProvided))
//                    return
//                }
//                print("Data downloaded from server - done: ", data)
//    
//                //выводим в основной поток (перестаховка)
//                DispatchQueue.main.async {
//                    completion(.success(dataGeoJson))
//                }
//            }.resume()
//        }
//    
//    //MARK: -> расчет расстояния по координатам
//    func getDistance(coordinatesArr: [[[[Double]]]]) -> Double? {
//        
//        var distancesArr = [Double]()
//        var distancesSum: Double = 0.0
//        
//        for i in coordinatesArr {
//            
//            let tmpCoordArr = i
//            print("coordinates", tmpCoordArr.count)
//            
//            for object in tmpCoordArr {
//                
//                let tmpCoordArr = object
//                var tmpArrayOfCllocationCoordinates = [CLLocation]()
//                for element in tmpCoordArr {
//                    let longtitude = element[0]
//                    let latitude = element[1]
//                    let location = CLLocation(latitude: latitude, longitude: longtitude)
//                    tmpArrayOfCllocationCoordinates.append(location)
//                }
//                print("tmpArrayOfCllocationCoordinates - filed - done - ", tmpArrayOfCllocationCoordinates.count )
//                
//                var tmpDistance: Double = 0.0
//                for i in 0..<tmpArrayOfCllocationCoordinates.count-1 {
//                    let distance = tmpArrayOfCllocationCoordinates[i].distance(from: tmpArrayOfCllocationCoordinates[i+1])
//                    tmpDistance += distance.rounded()
//                }
//                distancesArr.append(tmpDistance)
//                distancesSum += tmpDistance
//            }
//        }
//        
//        print("distancesArr count - ", distancesArr.count)
//        self.arrayOfDistances = distancesArr
//        print("distancesSum is - ", distancesSum)
//        return distancesSum
//    }
//    
//    //MARK: -> Создание MapView
//    func setupMapView() {
//        // Создаю View карты
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
//        if self.totalDistance != 0.0 {
//            let distanceToPrint = (self.totalDistance/1000).rounded() // округлено и в км
//            distanceString = "Общая протяженность маршрута: \(distanceToPrint) км."
//            } else {
//                distanceString = "Дистанция - не определена!"
//            }
//        distanceLabel.font = UIFont(name: "Avenir", size: 14)
//        distanceLabel.text = distanceString
//        self.mapView.addSubview(distanceLabel)
//        // to do constraint for label
//        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            distanceLabel.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -20.0),
//            distanceLabel.leftAnchor.constraint(equalTo: mapView.leftAnchor)
//        ])
//    
//        self.mapView.delegate = self
//        self.view.addSubview(self.mapView)
//        print("mapView - добавлен на View")
//        }
//}
//
//extension MainVC: MKMapViewDelegate {
//    
//    func mapView(_ mapView: MKMapView, didAdd renderers: [MKOverlayRenderer]) {
//                print("didAdd renderers")
//            }
//    
//            func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//                if let polygon = overlay as? MKPolygon {
//                 let renderer = MKPolygonRenderer(polygon: polygon)
//                    renderer.fillColor = UIColor.systemBlue
//                    renderer.strokeColor = UIColor.green
//                    renderer.lineWidth = 10
//                    return renderer
//                } else if let polyline = overlay as? MKPolyline {
//                    let plline = MKPolylineRenderer(overlay: polyline)
//                    plline.strokeColor = UIColor.systemPink
//                    return plline
//                } else if let multiPolygon = overlay as? MKMultiPolygon {
//                    let mltPolygon = MKMultiPolygonRenderer(multiPolygon: multiPolygon)
//                    mltPolygon.strokeColor = UIColor.red
//                    mltPolygon.fillColor = UIColor.gray
//                    print("catched Multipolygone")
//                    return mltPolygon
//                } else if let multipolyline  = overlay as? MKMultiPolyline {
//                    let mltPolyline = MKMultiPolylineRenderer(multiPolyline: multipolyline)
//                    mltPolyline.strokeColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
//                    mltPolyline.fillColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
//                    print("catched Multipolyline ")
//                    return mltPolyline
//                }
//                print("smth done in rendererFor overlay")
//                return MKOverlayRenderer(overlay: overlay)
//    
//            }
//}
//
////MARK: -> AppError
//enum AppError: Error {
//    case noDataProvided
//    case failedToDecode
//    case errorTask
//    case notCorrectUrl
//    case guardError
//    case failToFullArrayWithCoordinates
//}
//
////MARK: -> GeoJSONResponse struct
//struct GeoJSONResponse: Codable {
//    let type: String
//    let features: [Feature]
//}
//
//struct Feature: Codable {
//    let type: String
//    let properties: Properties
//    let geometry: Geometry
//}
//
//struct Geometry: Codable {
//    let type: String
//    let coordinates: [[[[Double]]]]
//}
//
//struct Properties: Codable {
//}
