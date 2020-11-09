//
//  TodayResponse.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/10.
//

struct TodayResponse: Decodable {
    var result: [TodayResult]
    var isSuccess: Bool
    var code: Int
    var LastCursor: Int
    var message: String
}

struct TodayResult: Decodable {
    var ThumbnailUrl: String
    var IconImage: String
    var ApplicationId: Int
    var ApplicationName: String
    var Price: Int
    var InAppPurchase: String
    var Summary: String
    var Category: String
    var DetailInfo: String
    var ImageSet: [PreviewImage]
}

struct PreviewImage: Decodable {
    var AppImages: String
}
