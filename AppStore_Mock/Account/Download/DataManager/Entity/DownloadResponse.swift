//
//  DownloadResponse.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/12.
//

struct DownloadResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: DownloadResult?
}

struct DownloadResult: Decodable {
    var ApplicationId: Int
    var ApplicationName: String
}
