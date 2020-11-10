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
        let original = "\(Constant.BASEL_URL)/apps/searchword" + "?word=\(searchKeyword)"
        
        guard let target = original.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            // 인코딩중 에러가 발생함
            return
        }

        guard let url = URL(string: target) else {
            // URL로 만들다가 에러가 발생함
            return
        }
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseDecodable(of: SearchResponse.self) { (response) in
            switch response.result {
            case .success(let response):
                if response.isSuccess, let result = response.result {
                    viewController.didRetrieveSearchResults(result: result)
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
