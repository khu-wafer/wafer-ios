//
//  WarehouseAPI.swift
//  khu-wafer
//
//  Created by 김담인 on 2023/06/02.
//

import Foundation
import Moya

final class WarehouseAPI {
    
    static let shared: WarehouseAPI = WarehouseAPI()
    private let WarehouseProvider = MoyaProvider<WarehouseService>(plugins: [MoyaLoggingPlugin()])
    private init() { }
    
    public private(set) var registerResponse:RegisterResponseModel?
    // MARK: - PostAloneFunction
    func postWarehouseProduct(data: PostRegisterModel,completion: @escaping (RegisterResponseModel?) -> ()) {
        WarehouseProvider.request(.register(data: data)) { [weak self] response in
            switch response {
            case .success(let result):
                do {
                    self?.registerResponse = try result.map(RegisterResponseModel?.self)
                    guard let bindedData = self?.registerResponse else {
                        return
                    }
                    // 리스폰스 전달
                    completion(bindedData)
                } catch(let err) {
                    print("실패")
                    print(err.localizedDescription)
                    completion(nil)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
