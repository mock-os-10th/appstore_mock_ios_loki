//
//  LogInViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/12.
//

import UIKit
import SwiftKeychainWrapper

class LogInViewController: UIViewController {
    var appIconImageUrl: String?
    var applicationId: Int?
    var appName: String?
    var devName: String?
    var inAppPurchase: String?
    var price: Int?
    var sender: UIButton?
    
    init(appIconImageUrl: String, applicationId: Int, appName: String, devName: String, inAppPurchase: String, price: Int) {
        self.appIconImageUrl = appIconImageUrl
        self.applicationId = applicationId
        self.appName = appName
        self.devName = devName
        self.inAppPurchase = inAppPurchase
        self.price = price
        
        super.init(nibName: "LogInViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func logInButtonClicked(_ sender: Any) {
        LogInDataManager.shared.logIn(viewController: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LogInViewController {
    func didRetrieveLogInResult(result: LogInResult) {
        guard let presentingViewController = self.presentingViewController, let applicationId = self.applicationId, let appName = self.appName, let devName = self.devName, let appIconImageUrl = self.appIconImageUrl, let inAppPurchase = self.inAppPurchase, let price = self.price else {
            print("presentingViewController 없음")
            return
        }
        KeychainWrapper.standard.set(result.jwt, forKey: "jwt")
        print("앱 내 로그인 성공")
        self.dismiss(animated: true) {
            let downloadViewController = DownloadViewController(appIconImageUrl: appIconImageUrl, applicationId: applicationId, appName: appName, devName: devName, inAppPurchase: inAppPurchase, price: price)
            downloadViewController.sender = self.sender
            print("presentingViewController 있음")
            if let baseViewController = presentingViewController as? BaseViewController {
                presentingViewController.present(downloadViewController, animated: true) {
                    baseViewController.setUpAccountButtonImage(url: KeychainWrapper.standard.string(forKey: .profileUrl))
                }
            } else {
                presentingViewController.present(downloadViewController, animated: true, completion: nil)
            }
        }
    }
    
    func failedToLoginResult(message: String) {
        self.presentAlert(title: message)
    }
}
