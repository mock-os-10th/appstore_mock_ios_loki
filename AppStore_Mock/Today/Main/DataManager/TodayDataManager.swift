//
//  TodayDataManager.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/10.
//
import Alamofire

class TodayDataManager {
    static let shared = TodayDataManager()
    
    func getAdvertisements(viewController: TodayMainViewController) {
        let url = "\(Constant.BASEL_URL)/advertisement"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseDecodable(of: TodayResponse.self) { (response) in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    viewController.didRetrieveAdvertisements(result: response.result)
                } else {
                    viewController.failedToRequest(message: response.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
                viewController.failedToRequest(message: "서버와의 연결이 원할하지 않습니다.")
            }
        }
    }

}
