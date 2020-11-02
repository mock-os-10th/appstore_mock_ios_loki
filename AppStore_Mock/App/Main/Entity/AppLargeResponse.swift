//
//  AppLargeResponse.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/02.
//

struct AppLargeResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var result: [AppLargeResult]
    init(isSuccess: Bool, code: Int, result: [AppLargeResult]) {
        self.isSuccess = isSuccess
        self.code = code
        self.result = result
    }
}

struct AppLargeResult: Decodable {
    var thumbnailUrl: String
    var ApplicationID: Int
    var ApplicationName: String
    var Summary: String
    var Category: String
    init(thumbnailUrl: String, ApplicationID: Int, ApplicationName: String, Summary: String, Category: String) {
        self.thumbnailUrl = thumbnailUrl
        self.ApplicationID = ApplicationID
        self.ApplicationName = ApplicationName
        self.Summary = Summary
        self.Category = Category
    }
}
