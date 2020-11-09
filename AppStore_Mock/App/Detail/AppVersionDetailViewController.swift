//
//  AppVersionDetailViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/08.
//

import UIKit

class AppVersionDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    
    var appUpdateInfoResult: [AppUpdateInfoResult]?
    
    init(_ appUpdateInfoResult: [AppUpdateInfoResult]?) {
        self.appUpdateInfoResult = appUpdateInfoResult
        
        super.init(nibName: "AppVersionDetailViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        self.tableView.register(UINib(nibName: "AppDetailUpdateInfoTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "AppDetailUpdateInfoTableViewCell")
        self.tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if let newValue = change?[.newKey], let newSize = newValue as? CGSize {
                self.tableViewHeight.constant = newSize.height
            }
        }
    }
    

}

extension AppVersionDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appUpdateInfoResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let result = appUpdateInfoResult?[indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailUpdateInfoTableViewCell", for: indexPath) as? AppDetailUpdateInfoTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        }
        
        cell.versionLabel.text = result.UpdateVer
        cell.detailLabel.text = result.Contents
        cell.dayLabel.text = result.UpdateTime.beforedays
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
