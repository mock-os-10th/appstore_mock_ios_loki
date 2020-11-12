//
//  LogInDataManager.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/11.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import Alamofire
import SwiftKeychainWrapper

class LogInDataManager {
    static let shared = LogInDataManager()
    
    func logIn(viewController: LogInViewController) {
        let url = "\(Constant.BASEL_URL)/user"
        AuthApi.shared.loginWithKakaoAccount { (oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                print("카카오 로그인 성공")
                
                if let oauthToken = oauthToken {
                    UserApi.shared.me { (user, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            if let user = user {
                                print("Access Token is " + oauthToken.accessToken)
                                let params: Parameters = ["X_ACCESS_TOKEN": oauthToken.accessToken]
                                AF.request(url, method: .post, parameters: params, headers: nil).validate().responseDecodable(of: LogInResponse.self) { (response) in
                                    print(response.result)
                                    switch response.result {
                                    case .success(let response):
                                        if response.isSuccess {
                                            if let kakaoEmail = user.kakaoAccount?.email {
                                                print("email is \(kakaoEmail)")
                                                KeychainWrapper.standard.set(kakaoEmail, forKey: "email")
                                            }
                                            if let name = user.kakaoAccount?.profile?.nickname {
                                                print("name is \(name)")
                                                KeychainWrapper.standard.set(name, forKey: "name")
                                            }
                                            if let profileUrl = user.kakaoAccount?.profile?.profileImageUrl?.absoluteString {
                                                print("profileUrl is \(profileUrl)")
                                                KeychainWrapper.standard.set(profileUrl, forKey: "profileUrl")
                                            }
                                            if let result = response.result {
                                                viewController.didRetrieveLogInResult(result: result)
                                            }
                                        } else {
                                            viewController.failedToLoginResult(message: response.message)
                                        }
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                        viewController.failedToLoginResult(message: "서버와의 연결이 원활하지 않습니다.")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func logIn(viewController: AccountMainViewController) {
        let url = "\(Constant.BASEL_URL)/user"
        AuthApi.shared.loginWithKakaoAccount { (oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                print("카카오 로그인 성공")
                
                if let oauthToken = oauthToken {
                    UserApi.shared.me { (user, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            if let user = user {
            
                                print("Access Token is " + oauthToken.accessToken)
                                let params: Parameters = ["X_ACCESS_TOKEN": oauthToken.accessToken]
                                AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).validate().responseDecodable(of: LogInResponse.self) { (response) in
                                    print(response.result)
                                    switch response.result {
                                    case .success(let response):
                                        if response.isSuccess {
                                            if let kakaoEmail = user.kakaoAccount?.email {
                                                print("email is \(kakaoEmail)")
                                                KeychainWrapper.standard.set(kakaoEmail, forKey: "email")
                                            }
                                            if let name = user.kakaoAccount?.profile?.nickname {
                                                print("name is \(name)")
                                                KeychainWrapper.standard.set(name, forKey: "name")
                                            }
                                            if let profileUrl = user.kakaoAccount?.profile?.profileImageUrl?.absoluteString {
                                                print("profileUrl is \(profileUrl)")
                                                KeychainWrapper.standard.set(profileUrl, forKey: "profileUrl")
                                            }
                                            if let result = response.result {
                                                viewController.didRetrieveLogInResult(result: result)
                                            }
                                        } else {
                                            viewController.failedToLoginResult(message: response.message)
                                        }
                                    case .failure(let error):
                                        print(error)
                                        viewController.failedToLoginResult(message: "서버와의 연결이 원활하지 않습니다.")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func logOut(viewController: AccountMainViewController) {
        KeychainWrapper.standard.remove(forKey: .jwt)
        KeychainWrapper.standard.remove(forKey: .email)
        KeychainWrapper.standard.remove(forKey: .name)
        KeychainWrapper.standard.remove(forKey: .profileUrl)
        
        UserApi.shared.logout { (error) in
            if let error = error {
                print(error.localizedDescription)
                viewController.failedToLogOut(message: "로그아웃에 실패했습니다")
            } else {
                viewController.finishLogOut()
            }
        }
    }
}
