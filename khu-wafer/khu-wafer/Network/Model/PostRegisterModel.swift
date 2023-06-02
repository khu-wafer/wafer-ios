//
//  PostRegisterModel.swift
//  khu-wafer
//
//  Created by 김담인 on 2023/06/02.
//

import Foundation

struct PostRegisterModel: Codable {
    let name, status, arrivalDate: String
    let shipmentDate, departure, arrivals: String
    let imgUrl: String
    
    
}
