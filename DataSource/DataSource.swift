//
//  DataSource.swift
//  WeatherApp
//
//  Created by AbdulHameed Mohamed on 17/05/2024.
//

import Foundation

protocol DataSource {
    func makeCallToApi<T: Decodable>(url: String, params: [String: Any], completion: @escaping (T?, Error?) -> Void)
}
