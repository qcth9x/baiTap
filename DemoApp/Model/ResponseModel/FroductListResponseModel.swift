//
//  FroductListResponseModel.swift
//  DemoApp
//
//  Created by Lê Đình Linh on 08/07/2023.
//

import Foundation

struct FroductListResponseModel : Decodable {
    var id : String
    var shopName : String
    var productName : String
    var productPice : String
    var avatar : String
    var danhGia : String
    var sizeA : String
    var sizeB : String
    var sizeC : String
    
    enum CodingKeys : String , CodingKey {
        case id = "id"
        case shopName = "shopName"
        case productName = "productName"
        case productPice = "productPice"
        case avatar = "avatar"
        case danhGia = "danhGia"
        case sizeA = "sizeA"
        case sizeB = "sizeB"
        case sizeC = "sizeC"
    }
}

typealias FroductList = [FroductListResponseModel]
