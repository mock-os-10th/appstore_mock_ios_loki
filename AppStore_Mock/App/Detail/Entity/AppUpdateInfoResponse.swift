//
//  AppUpdateInfoResponse.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/08.
//

struct AppUpdateInfoResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [AppUpdateInfoResult]
}

struct AppUpdateInfoResult: Decodable {
    var UpdateVer: String
    var UpdateTime: Int
    var Contents: String
}
