//
//  PurchaseListDataManager.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/13.
//

import Foundation
import Alamofire

class PurchaseListDataManager {
    static let shared = PurchaseListDataManager()
    
    func getPurchaseList(jwt: String, viewController: PurchaseListViewController) {
        let url = "\(Constant.BASEL_URL)/user/download" + "?kind=purchase"
        let headers: HTTPHeaders = ["JWT": jwt]
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: PurchaseListResponse.self) { (response) in
            switch response.result {
            case .success(let response):
                viewController.didRetrievePurchaseList(results: response.result)
            case .failure(let error):
                print(error.localizedDescription)
                viewController.failedToRetrievePurchaseList(message: "서버와의 연결이 원활하지 않습니다.")                
            }
        }
    }
}
