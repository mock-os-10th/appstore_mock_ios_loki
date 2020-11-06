//
//  AppSmallResponse.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/02.
//

struct AppSmallResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var result: [AppSmallResult]
    var keyword: String
    var message: String
}

struct AppSmallResult: Decodable {
    var IconImage: String
    var ApplicationId: Int
    var ApplicationName: String
    var Summary: String
    var Price: Int
    var InAppPurchase: String
}
