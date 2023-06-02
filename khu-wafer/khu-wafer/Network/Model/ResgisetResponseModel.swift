//
//  ResgisetResponseModel.swift
//  khu-wafer
//
//  Created by 김담인 on 2023/06/02.
//

import Foundation

struct RegisterResponseModel: Codable {
    let id, name, status, arrivalDate: String
    let shipmentDate, departure, arrivals: String
    let imgUrl: String
        
}
