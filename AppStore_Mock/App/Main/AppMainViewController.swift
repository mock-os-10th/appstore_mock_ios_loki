//
//  AppMainViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/01.
//

import UIKit


class AppMainViewController: BaseViewController {
    var appLargeResponse: AppLargeResponse?
    
    var appSmallResponses: [AppSmallResponse] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.navigationItem.title = "앱"
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "AppLargeCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AppLargeCell")
        self.collectionView.register(UINib(nibName: "AppSmallCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AppSmallCell")
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
        
        
        self.showIndicator()
        
        AppDataManager.shared.getAdvertisements(viewController: self)
        AppDataManager.shared.getAppList(targetList: "popularity", pageNum: 1, viewController: self)
        AppDataManager.shared.getAppList(targetList: "newupdate", pageNum: 1, viewController: self)
        AppDataManager.shared.getAppList(targetList: "popularityfinance", pageNum: 1, viewController: self)
        
//        AppDataManager().getAppList(targetList: "popularity", viewController: self)
//        AppDataManager().getAppList(targetList: "newupdate", viewController: self)
//        AppDataManager().getAppList(targetList: "popularityfinance", viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
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
        self.dismissIndicator()
        self.collectionView.reloadData()
    }
    
    func didRetrieveAdvertisements(result: AppLargeResponse) {
        self.appLargeResponse = result
        self.dismissIndicator()
        self.collectionView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.dismissIndicator()
        self.presentAlert(title: message)
    }
    
    @objc func seeAllButtonClicked(sender: UIButton) {
        let appListViewController = AppListViewController(response: appSmallResponses[sender.tag])
        
        self.navigationController?.pushViewController(appListViewController, animated: true)
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
                if let appLargeResponse = appLargeResponse {
                    cell.result = appLargeResponse.result
                }
                cell.parentViewController = self
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
                cell.parentViewController = self
                if let result = appSmallResponses[indexPath.row - 1].result {
                    cell.result = result
                }
                cell.seeAllButton.tag = indexPath.row - 1
                cell.seeAllButton.addTarget(self, action: #selector(seeAllButtonClicked(sender:)), for: .touchUpInside)
                
                
                return cell
            }
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: UIScreen.main.bounds.size.width, height: 300)
        }
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: 350)
    }
    
}

