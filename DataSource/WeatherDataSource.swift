//
//  WeatherDataSource.swift
//  WeatherApp
//
//  Created by AbdulHameed Mohamed on 17/05/2024.
//

import Foundation
import Alamofire

class WeatherDataSource: DataSource {
    static let api = WeatherDataSource()
    
    func makeCallToApi<T: Decodable>(url: String, params: [String: Any], completion: @escaping (T?, Error?) -> Void) {
        AF.request(url, parameters: params).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let decodedData):
                completion(decodedData, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
