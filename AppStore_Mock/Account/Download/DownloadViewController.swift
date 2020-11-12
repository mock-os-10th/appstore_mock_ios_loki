//
//  DownloadViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/12.
//

import UIKit
import SwiftKeychainWrapper

class DownloadViewController: UIViewController {
    
    var appIconImageUrl: String?
    var applicationId: Int?
    var appName: String?
    var devName: String?
    var inAppPurchase: String?
    var price: Int?
    var sender: UIButton?
    
    var baseVC: BaseViewController?
    var todayVC: TodayDetailViewController?
    
    
    init(appIconImageUrl: String, applicationId: Int, appName: String, devName: String, inAppPurchase: String, price: Int) {
        self.appIconImageUrl = appIconImageUrl
        self.applicationId = applicationId
        self.appName = appName
        self.devName = devName
        self.inAppPurchase = inAppPurchase
        self.price = price
        
        super.init(nibName: "DownloadViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    @IBOutlet weak var appView: UIView!
    @IBOutlet weak var accountView: UIView!
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var appIconImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var devNameLabel: UILabel!
    @IBOutlet weak var inAppPurchaseLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let email = KeychainWrapper.standard.string(forKey: .email) {
            accountLabel.text = email
        }
        self.downloadButton.layer.cornerRadius = 20
        self.downloadButton.clipsToBounds = true
        self.downloadButton.addTarget(self, action: #selector(downloadButtonClicked), for: .touchUpInside)
        
        self.appIconImageView.layer.cornerRadius = 8
        self.appIconImageView.clipsToBounds = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let appIconImageUrl = appIconImageUrl {
            appIconImageView.setImage(url: appIconImageUrl)
        }
        
        if let appName = appName {
            appNameLabel.text = appName
        }
        
        if let devName = devName {
            devNameLabel.text = devName
        }
        
        if let inAppPurchase = inAppPurchase, inAppPurchase == "N" {
            inAppPurchaseLabel.isHidden = true
        }
        
        if let email = KeychainWrapper.standard.string(forKey: .email) {
            accountLabel.text = email
        }
        
        // 다운로드가 되어있는 지 확인해야 함
        if let price = price, price > 0 {
            downloadButton.setTitle("₩\(price)", for: .normal)
        }
    }
    
}

extension DownloadViewController {
    @objc func downloadButtonClicked() {
        guard let jwt = KeychainWrapper.standard.string(forKey: .jwt), let applicationId = applicationId else {
            return
        }
        
        // 다운로드 된 앱인지 확인해야 함
        
        DownloadDataManager.shared.downloadRequest(applicationId: applicationId, jwt: jwt, viewController: self)
    }
    
    func finishDownload() {
        print("다운로드가 완료되었습니다.")
        if let appName = appName {
            UserDefaults.standard.setValue(true, forKey: appName)
        }
        self.dismiss(animated: true) {
            guard let button = self.sender else {
                return
            }
            button.setTitle("열기", for: .normal)
            button.removeTarget(nil, action: nil, for: .allEvents)
        }
    }
    
    func failedToDownload(message: String) {
        self.presentAlert(title: message)
    }
}
