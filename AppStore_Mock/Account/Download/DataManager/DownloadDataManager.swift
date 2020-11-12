//
//  DownloadDataManager.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/12.
//

import Alamofire

class DownloadDataManager {
    static let shared = DownloadDataManager()
    
    
    func downloadRequest(applicationId: Int, jwt: String, viewController: DownloadViewController) {
        let url = "\(Constant.BASEL_URL)/user/download"
        let param: Parameters = ["ApplicationId": applicationId]
        let header: HTTPHeaders = ["jwt": jwt]
        print("jwt is \(jwt)")
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).validate().responseDecodable(of: DownloadResponse.self) { (response) in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    viewController.finishDownload()
                } else {
                    viewController.failedToDownload(message: response.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
                viewController.failedToDownload(message: "서버와의 연결이 원활하지 않습니다")
            }
        }
    }
}
