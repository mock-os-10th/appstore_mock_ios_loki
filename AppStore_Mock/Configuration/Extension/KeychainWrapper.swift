//
//  KeychainWrapper.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/11.
//

import Foundation
import SwiftKeychainWrapper

extension KeychainWrapper.Key {
    static let jwt: KeychainWrapper.Key = "jwt"
    static let email: KeychainWrapper.Key = "email"
    static let name: KeychainWrapper.Key = "name"
    static let profileUrl: KeychainWrapper.Key = "profileUrl"
}
