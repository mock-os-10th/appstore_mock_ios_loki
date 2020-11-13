//
//  AppListViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/13.
//

import UIKit
import SwiftKeychainWrapper

class AppListViewController: UIViewController {
    var keyword: String?
    var results: [AppSmallResult] = []
    var isLoading = false
    var isEnded = false
    var page: Int = 1
    
    @IBOutlet weak var tableView: UITableView!
    
    init(response: AppSmallResponse) {
        super.init(nibName: "AppListViewController", bundle: Bundle.main)
        self.keyword = response.keyword
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        switch keyword {
        case "popularity":
            self.title = "인기 앱"
        case "popularityfinance":
            self.title = "인기 금융 앱"
        case "newupdate":
            self.title = "따끈따끈한 업데이트"
        default:
            break
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.register(UINib(nibName: "AppListLargeCell", bundle: Bundle.main), forCellReuseIdentifier: "AppListLargeCell")
        self.showIndicator()
        loadMoreData()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension AppListViewController {
    @objc func downloadButtonClicked(sender: UIButton) {
        if KeychainWrapper.standard.string(forKey: .jwt) == nil {
            let logInViewController = LogInViewController(appIconImageUrl: results[sender.tag].IconImage, applicationId: results[sender.tag].ApplicationId, appName: results[sender.tag].ApplicationName, devName: results[sender.tag].Summary, inAppPurchase: results[sender.tag].InAppPurchase, price: results[sender.tag].Price)
            logInViewController.sender = sender
            self.present(logInViewController, animated: true, completion: nil)
        } else {
            let downloadViewController = DownloadViewController(appIconImageUrl: results[sender.tag].IconImage, applicationId: results[sender.tag].ApplicationId, appName: results[sender.tag].ApplicationName, devName: results[sender.tag].Summary, inAppPurchase: results[sender.tag].InAppPurchase, price: results[sender.tag].Price)
            downloadViewController.sender = sender
            downloadViewController.modalPresentationStyle = .overFullScreen
            self.present(downloadViewController, animated: true, completion: nil)
        }
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            if let keyword = keyword {
                AppDataManager.shared.getAppList(targetList: keyword, pageNum: page, viewController: self)
            } else {
                self.isLoading = false
            }
        }
    }
    
    func didRetrieveAppList(result: [AppSmallResult]) {
        self.page += 1
        self.isLoading = false
        if result.count < 12 {
            self.isEnded = true
        }
        self.dismissIndicator()
        self.results.append(contentsOf: result)
        self.tableView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}

//extension AppListViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//
//        if (offsetY > contentHeight - scrollView.frame.height * 4), !isLoading {
//            loadMoreData()
//        }
//    }
//}

extension AppListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppListLargeCell", for: indexPath) as? AppListLargeCell else {
            return UITableViewCell()
        }
        
        cell.appIconImageView.setImage(url: results[indexPath.row].IconImage)
        cell.appNameLabel.text = results[indexPath.row].ApplicationName
        cell.appDetailLabel.text = results[indexPath.row].Summary
        if results[indexPath.row].InAppPurchase == "N" {
            cell.inAppPurchaseLabel.isHidden = true
        }
                
        if UserDefaults.standard.value(forKey: results[indexPath.row].ApplicationName) != nil {
            cell.downloadButton.setTitle("열기", for: .normal)
        } else {
            if results[indexPath.row].Price > 0 {
                cell.downloadButton.setTitle(results[indexPath.row].Price.price, for: .normal)
            } else {
                cell.downloadButton.setTitle("받기", for: .normal)
                cell.tag = indexPath.row
                cell.downloadButton.addTarget(self, action: #selector(downloadButtonClicked(sender:)), for: .touchUpInside)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.results.count - 2, !self.isLoading, !self.isEnded {
            loadMoreData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDetailViewController = AppDetailViewController(results[indexPath.row].ApplicationId)
        
        self.navigationController?.pushViewController(appDetailViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
