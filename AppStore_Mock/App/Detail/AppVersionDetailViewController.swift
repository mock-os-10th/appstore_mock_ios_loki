//
//  AppVersionDetailViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/08.
//

import UIKit

class AppVersionDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    var appUpdateInfoResult: [AppUpdateInfoResult]? {
        didSet {
            if appUpdateInfoResult != nil {
                self.tableView.reloadData()
            }
        }
    }
    
    init(_ appUpdateInfoResult: [AppUpdateInfoResult]?) {
        self.appUpdateInfoResult = appUpdateInfoResult
        
        super.init(nibName: "AppVersionDetailViewController", bundle: nil)
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
        self.tableView.register(UINib(nibName: "AppDetailUpdateInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "AppDetailUpdateInfoTableViewCell")
        self.tableView.allowsSelection = false
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
    
    
}
