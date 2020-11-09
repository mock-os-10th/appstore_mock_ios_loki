//
//  AppDetailViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/05.
//

import UIKit
import SnapKit

class AppDetailViewController: UIViewController {
    var applicationId: Int?
    let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(35)
        }
        return imageView
    }()
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        return button
    }()
    
    init(_ applicationId: Int) {
        self.applicationId = applicationId
        
        super.init(nibName: "AppDetailViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var appDetailResult: AppDetailResult? {
        didSet {
            guard let result = appDetailResult else {
                return
            }
            appIconImageView.setImage(url: result.IconImage)
            if result.Price > 0 {
                downloadButton.setTitle("₩\(result.Price)", for: .normal)
            }
        }
    }
    var appUpdateInfoResult: [AppUpdateInfoResult]?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        if let applicationId = applicationId {
            AppDetailDataManager.shared.getAppDetailInfoOfApplicationId(applicationId: applicationId, viewController: self)
            AppDetailDataManager.shared.getAppVersionsOfApplicationId(applicationId: applicationId, viewController: self)
            self.showIndicator()
        }
        self.navigationController?.navigationBar.standardAppearance.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance.shadowColor = .clear
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: nil, action: nil)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        self.tableView.register(UINib(nibName: "AppDetailHeaderTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "AppDetailHeaderTableViewCell")
        self.tableView.register(UINib(nibName: "AppDetailStackViewCell", bundle: Bundle.main), forCellReuseIdentifier: "AppDetailStackViewCell")
        self.tableView.register(UINib(nibName: "AppDetailImagesCell", bundle: Bundle.main), forCellReuseIdentifier: "AppDetailImagesCell")
        self.tableView.register(UINib(nibName: "AppDetailInfoCell", bundle: Bundle.main), forCellReuseIdentifier: "AppDetailInfoCell")
        self.tableView.register(UINib(nibName: "AppDetailUpdateInfoCell", bundle: Bundle.main), forCellReuseIdentifier: "AppDetailUpdateInfoCell")
        self.tableView.register(UINib(nibName: "AppDetailInfoTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "AppDetailInfoTableViewCell")
        self.tableView.allowsSelection = false
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addSubviewsOfNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        dismissSubviewsOfNavigationBar()
    }
}

extension AppDetailViewController {
    func didRetrieveAppList(result: AppDetailResult) {
        self.appDetailResult = result
        print("\(result.ApplicationName) 정상적으로 호출 완료")
        self.dismissIndicator()
        self.tableView.reloadData()
    }
    
    func didRetrieveAppUpdateInfo(result: [AppUpdateInfoResult]) {
        self.appUpdateInfoResult = result
        print("앱 업데이트 기록 호출 완료")
        self.tableView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.dismissIndicator()
        self.presentAlert(title: message)
    }
    
    func addSubviewsOfNavigationBar() {
        self.navigationItem.titleView = appIconImageView
        self.navigationController?.navigationBar.addSubview(downloadButton)
        downloadButton.snp.makeConstraints { (make) in
            make.width.equalTo(65)
            make.right.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
    }
    
    func dismissSubviewsOfNavigationBar() {
        self.navigationItem.titleView = nil
        downloadButton.removeFromSuperview()
    }
    
    @objc func pushVersionDetailViewController() {
        let appVersionDetailViewController = AppVersionDetailViewController(appUpdateInfoResult)
        
        self.navigationController?.pushViewController(appVersionDetailViewController, animated: true)
    }
}

extension AppDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let result = appDetailResult else {
            return tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        }
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailHeaderTableViewCell", for: indexPath) as? AppDetailHeaderTableViewCell {
                cell.appIconImageView.setImage(url: result.IconImage)
                cell.appNameLabel.text = result.ApplicationName
                cell.appSummaryLabel.text = result.Summary
                if result.Price > 0 {
                    cell.downloadButton.setTitle("₩\(result.Price)", for: .normal)
                }
                
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailStackViewCell", for: indexPath) as? AppDetailStackViewCell {
                cell.ageLabel.text = "\(result.Ages)+"
                cell.categoryLabel.text = result.Category
                cell.chartLabel.text = "#\(result.Chart)"
                cell.devNameLabel.text = result.DevName
                cell.wordLabel.text = result.Word
                cell.wordCountLabel.text = "+ \(result.WordCount)개 언어"
                
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailImagesCell", for: indexPath) as? AppDetailImagesCell {
                cell.images = result.ImageSet
                
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailInfoCell", for: indexPath) as? AppDetailInfoCell {
                cell.infoLabel.text = result.DetailInfo
                cell.devNameLabel.text = result.DevName
                
                return cell
            }
        case 4:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailUpdateInfoCell", for: indexPath) as? AppDetailUpdateInfoCell, let updateInfoResult = appUpdateInfoResult?.first {
                cell.versionLabel.text = updateInfoResult.UpdateVer
                cell.detailLabel.text = updateInfoResult.Contents
                cell.dayLabel.text = updateInfoResult.UpdateTime.beforedays
                cell.versionInfoButton.addTarget(self, action: #selector(pushVersionDetailViewController), for: .touchUpInside)
                
                return cell
            }
        case 5:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailInfoTableViewCell", for: indexPath) as? AppDetailInfoTableViewCell {
                cell.data = [("제공자", result.DevName), ("크기", result.Appsize), ("카테고리", result.Category), ("호환성", result.Compatibility), ("언어", result.WordDetail), ("연령 등급", "\(result.Ages)+"), ("저작권", result.Copyright)]
                
                return cell
            }
        default:
            break
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        } else if indexPath.row == 2 {
            return 420
        }
        
        return UITableView.automaticDimension
    }
}

extension AppDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            self.navigationController?.navigationBar.standardAppearance.backgroundColor = .white
            self.navigationController?.navigationBar.standardAppearance.shadowColor = .clear
        } else {
            self.navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor(red: 0.9763854146, green: 0.9765252471, blue: 0.9763546586, alpha: 1)
            self.navigationController?.navigationBar.standardAppearance.shadowColor = UIColor(red: 0.9763854146, green: 0.9765252471, blue: 0.9763546586, alpha: 1)
        }
        
        if scrollView.contentOffset.y > 150 {
            self.navigationItem.titleView?.isHidden = false
            self.downloadButton.isHidden = false
        } else {
            self.navigationItem.titleView?.isHidden = true
            self.downloadButton.isHidden = true
        }
    }
}
