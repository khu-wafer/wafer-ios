//
//  WarehouseService.swift
//  khu-wafer
//
//  Created by 김담인 on 2023/06/02.
//

import Foundation
import Moya

enum WarehouseService {
    // post
    case register(data: PostRegisterModel)
}

extension WarehouseService: BaseTargetType {
    var method: Moya.Method {
        switch self {
        case .register:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .register:
            return APIConstant.register
        }
    }
    
    var task: Task {
        switch self {
        case .register(let data):
            return .requestJSONEncodable(data)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .register:
            return NetworkConstant.noTokenHeader
        }
    }
}
