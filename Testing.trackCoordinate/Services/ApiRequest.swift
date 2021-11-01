////
////  ApiRequest.swift
////  Testing.trackCoordinate
////
////  Created by Maksim on 08.07.2021.
////
//
//import Foundation
//
//class ApiRequest {
//    
//    let urlString = "https://waadsu.com/api/russia.geo.json"
//    private var urlConstructor = URLComponents()
//    private let configuration: URLSessionConfiguration!
//    private let session: URLSession!
//    
//    init() {
//        //упрощенный вариант
//        urlConstructor.scheme = "https"
//        urlConstructor.host = "waadsu.com"
//        configuration = URLSessionConfiguration.default
//        session = URLSession(configuration: configuration)
//    }
//    
//    func getGeoJSONData(completion: @escaping (Swift.Result<GeoJSONResponse, AppError>) -> Void) {
//        //создаю url
//        urlConstructor.path = "/api/russia.geo.json"
////        guard let url = urlConstructor.url else {
////            completion(.failure(AppError.notCorrectUrl))
////            return
////        }
//        
//        guard let url = URL(string: urlString) as? URL else {
//            completion(.failure(AppError.notCorrectUrl))
//            return
//        }
//        
//        //создаю запрос
//        let task = session.dataTask(with: url ) { (data, response, error) in
//            //ловлю ошибки
//            if error != nil {
//                completion(.failure(AppError.errorTask))
//            }
//            //проверяю есть ли data
//            guard let data = data else {
//                completion(.failure(AppError.noDataProvided))
//                return
//            }
//            //парсим data
//            guard let parsedData = try? JSONDecoder().decode(GeoJSONResponse.self, from: data) else {
//                completion(.failure(AppError.failedToDecode))
//                return
//            }
//            //выводим в основной поток (перестаховка - если метод будет отправлен в фоновый поток)
//            DispatchQueue.main.async {
//                completion(.success(parsedData))
//            }
//        }
//        task.resume()
//    }
//    
//    
//}
