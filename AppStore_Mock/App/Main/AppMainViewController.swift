//
//  AppMainViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/01.
//

import UIKit

class AppMainViewController: UIViewController {
    var appLargeResponse: AppLargeResponse = AppLargeResponse(isSuccess: true, code: 100, result: [AppLargeResult(thumbnailUrl: "https://is2-ssl.mzstatic.com/image/thumb/Purple114/v4/d5/14/a7/d514a7fb-69e6-7519-e753-2527d12939f1/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationID: 1082345, ApplicationName: "어몽 어스", Summary: "마피아 게임", Category: "새로운 게임"), AppLargeResult(thumbnailUrl: "https://is2-ssl.mzstatic.com/image/thumb/Purple114/v4/d5/14/a7/d514a7fb-69e6-7519-e753-2527d12939f1/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationID: 1082345, ApplicationName: "어몽 어스", Summary: "마피아 게임", Category: "새로운 게임"), AppLargeResult(thumbnailUrl: "https://is2-ssl.mzstatic.com/image/thumb/Purple114/v4/d5/14/a7/d514a7fb-69e6-7519-e753-2527d12939f1/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationID: 1082345, ApplicationName: "어몽 어스", Summary: "마피아 게임", Category: "새로운 게임")])
    
    var appSmallResponses: [AppSmallResponse] = [] {
        didSet {
            if appSmallResponses.count == 3 {
                print("API 호출 모두 정상적으로 완료")
                self.dismissIndicator()
                self.collectionView.reloadData()
            }
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "AppLargeCell", bundle: nil), forCellWithReuseIdentifier: "AppLargeCell")
        self.collectionView.register(UINib(nibName: "AppSmallCell", bundle: nil), forCellWithReuseIdentifier: "AppSmallCell")
        self.showIndicator()
        AppDataManager().getAppList(targetList: "popularity", viewController: self)
        AppDataManager().getAppList(targetList: "newupdate", viewController: self)
        AppDataManager().getAppList(targetList: "popularityfinance", viewController: self)
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

extension AppMainViewController {
    func didRetrieveAppList(result: AppSmallResponse) {
        appSmallResponses.append(result)
    }
    
    func failedToRequest(message: String) {
        self.dismissIndicator()
        self.presentAlert(title: message)
    }
}

extension AppMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //0번째 row는 상단 광고 앱들, 1은 인기 앱 조회, 2는 따끈따끈한 업데이트, 3은 인기 금융 앱 조회
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appSmallResponses.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppLargeCell", for: indexPath) as? AppLargeCell {
                cell.result = appLargeResponse.result
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppSmallCell", for: indexPath) as? AppSmallCell {
                switch appSmallResponses[indexPath.row - 1].keyword {
                case "popularity":
                    cell.category = "인기 앱 조회"
                case "newupdate":
                    cell.category = "따끈따끈한 업데이트"
                case "popularityfinance":
                    cell.category = "인기 금융 앱 조회"
                    cell.isRatingResult = true
                default:
                    break
                }
                
                cell.result = appSmallResponses[indexPath.row - 1].result
                
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: UIScreen.main.bounds.size.width, height: 300)
        }
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: 320)
    }
    
}

