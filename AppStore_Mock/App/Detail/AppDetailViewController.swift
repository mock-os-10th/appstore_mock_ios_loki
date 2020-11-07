//
//  AppDetailViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/05.
//

import UIKit

class AppDetailViewController: UIViewController {
    
    var applicationId: Int?
    
    init(_ applicationId: Int) {
        self.applicationId = applicationId
        
        super.init(nibName: "AppDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var appDetailResult: AppDetailResult? {
        didSet {
            self.dismissIndicator()
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
        if let applicationId = applicationId {
            AppDetailDataManager.shared.getAppDetailInfoOfApplicationId(applicationId: applicationId, viewController: self)
            self.showIndicator()
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        self.tableView.register(UINib(nibName: "AppDetailStackViewCell", bundle: nil), forCellReuseIdentifier: "AppDetailStackViewCell")
        self.tableView.register(UINib(nibName: "AppDetailImagesCell", bundle: nil), forCellReuseIdentifier: "AppDetailImagesCell")
        self.tableView.register(UINib(nibName: "AppDetailInfoCell", bundle: nil), forCellReuseIdentifier: "AppDetailInfoCell")
        self.tableView.register(UINib(nibName: "AppDetailInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "AppDetailInfoTableViewCell")
        self.tableView.allowsSelection = false
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension

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

extension AppDetailViewController {
    func didRetrieveAppList(result: AppDetailResult) {
        self.appDetailResult = result
        print("\(result.ApplicationName) 정상적으로 호출 완료")
    }
    
    func failedToRequest(message: String) {
        self.dismissIndicator()
        self.presentAlert(title: message)
    }
}

extension AppDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let result = appDetailResult else {
            return tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        }
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailStackViewCell", for: indexPath) as? AppDetailStackViewCell {
                cell.ageLabel.text = "\(result.Ages)+"
                cell.categoryLabel.text = result.Category
                cell.chartLabel.text = "#\(result.Chart)"
                cell.devNameLabel.text = result.DevName
                cell.wordLabel.text = result.Word
                cell.wordCountLabel.text = "+ \(result.WordCount)개 언어"
                
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailImagesCell", for: indexPath) as? AppDetailImagesCell {
                cell.images = result.ImageSet
                
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailInfoCell", for: indexPath) as? AppDetailInfoCell {
                cell.infoLabel.text = result.DetailInfo
                cell.devNameLabel.text = result.DevName
                
                return cell
            }
        case 3:
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
        if indexPath.row == 1 {
            return 420
        }
        
        return UITableView.automaticDimension
    }
    

}
