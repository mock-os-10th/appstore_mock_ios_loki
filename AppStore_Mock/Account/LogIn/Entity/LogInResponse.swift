//
//  LogInResponse.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/11.
//

struct LogInResponse: Decodable {
    var result: LogInResult?
    var isSuccess: Bool
    var code: Int
    var message: String
}

struct LogInResult: Decodable {
    var jwt: String
}
