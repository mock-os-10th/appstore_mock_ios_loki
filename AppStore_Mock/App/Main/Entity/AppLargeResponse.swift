//
//  AppLargeResponse.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/02.
//

struct AppLargeResponse: Decodable {
    var result: [AppLargeResult]
    var isSuccess: Bool
    var code: Int
    var LastCursor: Int
    var message: String
}

struct AppLargeResult: Decodable {
    var ThumbnailUrl: String
    var IconImage: String
    var ApplicationId: Int
    var ApplicationName: String
    var Price: Int
    var InAppPurchase: String
    var Summary: String
    var Category: String
    var DetailInfo: String
    var ImageSet: [ImageResult]
}

struct ImageResult: Decodable {
    var AppImages: String
}
