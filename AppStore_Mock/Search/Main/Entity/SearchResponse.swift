//
//  SearchResponse.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/10.
//

struct SearchResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [SearchResult]?
}

struct SearchResult: Decodable {
    var IconImage: String
    var ApplicationId: Int
    var ApplicationName: String
    var Summary: String
    var Price: Int
    var InAppPurchase: String
    var ImageSet: [PreviewImageResult]
}

struct PreviewImageResult: Decodable {
    var AppImages: String
}
