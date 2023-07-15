//
//  APIHandler.swift
//  DemoApp
//
//  Created by Lê Đình Linh on 08/07/2023.
//

import Foundation
import Alamofire

class APIHandler {
    
    func getFroductList(completion: @escaping (FroductList) -> ()) {
        AF.request("https://64b0c92dc60b8f941af5fe53.mockapi.io/FroductList", method: .get).responseDecodable(of: FroductList.self) {
            (response) in
            if let froductListResponse = response.value {
                completion(froductListResponse)
            }
        }
    }
    
}
