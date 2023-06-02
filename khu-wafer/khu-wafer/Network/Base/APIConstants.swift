//
//  APIConstants.swift
//  khu-wafer
//
//  Created by 김담인 on 2023/06/02.
//

import Foundation

struct APIConstant {
    static let baseURL = {
        guard let base = Bundle.main.object(forInfoDictionaryKey: "BASE_API_KEY") as? String else {
            fatalError("Base URL not set in plist for this environment")
        }
        return base
    }()
    static let register = "/register"
}
