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
    init(isSuccess: Bool, code: Int, result: [AppSmallResult]) {
        self.isSuccess = isSuccess
        self.code = code
        self.result = result
    }
}

struct AppSmallResult: Decodable {
    var IconImage: String
    var ApplicationId: Int
    var ApplicationName: String
    var Summary: String
    var Price: Int
    init(IconImage: String, ApplicationId: Int, ApplicationName: String, Summary: String, Price: Int) {
        self.IconImage = IconImage
        self.ApplicationId = ApplicationId
        self.ApplicationName = ApplicationName
        self.Summary = Summary
        self.Price = Price
    }
}
