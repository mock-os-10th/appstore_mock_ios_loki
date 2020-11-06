//
//  AppDetailResponse.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/06.
//

struct AppDetailResponse: Decodable {
    var code: Int
    var isSuccess: Bool
    var message: String
    var result: AppDetailResult
}

struct AppDetailResult: Decodable {
    var IconImage: String
    var ApplicationId: Int
    var ApplicationName: String
    var Price: Int
    var Summary: String
    var Evaulation: Float
    var Ages: Int
    var Chart: Int
    var DevName: String
    var DetailInfo: String
    var AppSize: String
    var Category: String
    var Compatibility: String
    var Word: String
    var WordCount: Int
    var WordDetail: String
    var Copyright: String
    var ImageSet: [AppDetailImage]
}
struct AppDetailImage: Decodable {
    var AppImages: String
}
