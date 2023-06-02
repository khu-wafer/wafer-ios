//
//  BaseTaretType.swift
//  khu-wafer
//
//  Created by 김담인 on 2023/06/02.
//

import Foundation
import Moya

protocol BaseTargetType: TargetType { }

extension BaseTargetType {
    var baseURL: URL {
        return URL(string: APIConstant.baseURL)!
    }

}
