//
//  AppDetailDataManager.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/06.
//

import Alamofire

class AppDetailDataManager {
    static let shared = AppDetailDataManager()
    
    func getAppDetailInfoOfApplicationId(applicationId: Int, viewController: AppDetailViewController) {
        let url = "\(Constant.BASEL_URL)/application" + "/\(applicationId)" + "/specification"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseDecodable(of: AppDetailResponse.self) { (response) in
            switch response.result {
            case .success(let response):
                viewController.didRetrieveAppList(result: response.result)
            case .failure(let error):
                // error do something
                print(error.localizedDescription)
                viewController.failedToRequest(message: "서버와의 연결이 원활하지 않습니다.")
            }
        }
    }
    
    func getAppVersionsOfApplicationId(applicationId: Int, viewController: AppDetailViewController) {
        let url = "\(Constant.BASEL_URL)/application" + "/\(applicationId)" + "/updateinfo"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseDecodable(of: AppUpdateInfoResponse.self) { (response) in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    viewController.didRetrieveAppUpdateInfo(result: response.result)
                } else {
                    viewController.failedToRequest(message: response.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
                viewController.failedToRequest(message: "서버와의 연결이 원활하지 않습니다.")
            }
        }
        
    }
}

