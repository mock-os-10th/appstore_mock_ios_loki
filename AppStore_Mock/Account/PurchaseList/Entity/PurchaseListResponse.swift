//
//  PurchaseListResponse.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/13.
//

struct PurchaseListResponse: Decodable {
    var result: [PurchaseListResult]
    var isSuccess: Bool
    var code: Int
    var message: String
}

struct PurchaseListResult: Decodable {
    var ApplicationId: Int
    var DownloadAt: String
    var ModifyAt: String?
    var IconImage: String
    var ApplicationName: String
}
