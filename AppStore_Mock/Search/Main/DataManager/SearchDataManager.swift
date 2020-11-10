//
//  SearchDataManager.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/11.
//

import Alamofire

class SearchDataManager {
    static let shared =  SearchDataManager()
    
    func getSearchResults(searchKeyword: String, viewController: SearchMainViewController) {
        let url = "\(Constant.BASEL_URL)/apps/searchword" + "?word=\(searchKeyword)"
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseDecodable(of: SearchResponse.self) { (response) in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    viewController.didRetrieveSearchResults(result: response.result)
                } else {
                    viewController.failedToSearchRequest(message: response.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
                viewController.failedToSearchRequest(message: "서버와의 연결이 원활하지 않습니다.")
            }
        }
    }
}
