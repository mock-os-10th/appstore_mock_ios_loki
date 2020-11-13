//
//  PurchaseListViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/12.
//

import UIKit
import SwiftKeychainWrapper

class PurchaseListViewController: UIViewController {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var isFiltering: Bool = false
    var purchaseResults = [PurchaseListResult]()
    var filteredResults = [PurchaseListResult]()
    var purchaseResultsNotInPhone: [PurchaseListResult] {
        return purchaseResults.filter { (result) -> Bool in
            if UserDefaults.standard.value(forKey: result.ApplicationName) == nil {
                return true
            } else {
                return false
            }
        }
    }
    var filteredResultsNotInPhone = [PurchaseListResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "구입 항목"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(dismissPurchaseViewController))
        
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        self.scrollView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        self.tableView.register(UINib(nibName: "PurchaseListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "PurchaseListTableViewCell")
        
        if let jwt = KeychainWrapper.standard.string(forKey: .jwt) {
            print("jwt is \(jwt)")
            self.showIndicator()
            PurchaseListDataManager.shared.getPurchaseList(jwt: jwt, viewController: self)
        }
        self.segmentControl.addTarget(self, action: #selector(segmenteControlValueChanged), for: .valueChanged)
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
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PurchaseListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
        searchBar.resignFirstResponder()
    }
}

extension PurchaseListViewController {
    func getDay(day: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: day) {
            return Date().days(sinceDate: date)
        } else {
            return nil
        }
    }
    
    @objc func downloadButtonClicked(sender: UIButton) {
        // can't work becaouse I can't get information of application that I've never downloaded
    }
    
    @objc func segmenteControlValueChanged() {
        print("segment control value changed")
        self.tableView.reloadData()
    }
    
    @objc func dismissPurchaseViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didRetrievePurchaseList(results: [PurchaseListResult]) {
        print("구매 내역 받음")
        self.dismissIndicator()
        self.purchaseResults = results
        self.tableView.reloadData()
    }
    
    func failedToRetrievePurchaseList(message: String) {
        self.dismissIndicator()
        self.presentAlert(title: message)
    }
}

extension PurchaseListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isFiltering = false
            filteredResults.removeAll()
            filteredResultsNotInPhone.removeAll()
        } else {
            isFiltering = true
            filteredResults = purchaseResults.filter({ (result) -> Bool in
                return result.ApplicationName.lowercased().contains(searchBar.text!.lowercased())
            })
            filteredResultsNotInPhone = purchaseResultsNotInPhone.filter({ (result) -> Bool in
                return result.ApplicationName.lowercased().contains(searchBar.text!.lowercased())
            })
        }
        self.tableView.reloadData()
    }
}

extension PurchaseListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            if isFiltering {
                return filteredResults.count
            } else {
                return purchaseResults.count
            }
        case 1:
            if isFiltering {
                return filteredResultsNotInPhone.count
            } else {
                return purchaseResultsNotInPhone.count
            }
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseListTableViewCell", for: indexPath) as? PurchaseListTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        }
        switch segmentControl.selectedSegmentIndex {
        case 0:
            if isFiltering {
                cell.appNameLabel.text = filteredResults[indexPath.row].ApplicationName
                cell.appIconImageView.setImage(url: filteredResults[indexPath.row].IconImage)
                if UserDefaults.standard.value(forKey: filteredResults[indexPath.row].ApplicationName) != nil {
                    cell.downloadButton.setTitle("열기", for: .normal)
                } else {
                    cell.downloadButton.setTitle("받기", for: .normal)
                    cell.downloadButton.tag = indexPath.row
                    cell.downloadButton.addTarget(self, action: #selector(downloadButtonClicked(sender:)), for: .touchUpInside)
                    if let day = getDay(day: filteredResults[indexPath.row].DownloadAt) {
                        cell.dateLabel.text = "\(day)일 전"
                    } else {
                        cell.dateLabel.text = ""
                    }
                }
            } else {
                cell.appNameLabel.text = purchaseResults[indexPath.row].ApplicationName
                cell.appIconImageView.setImage(url: purchaseResults[indexPath.row].IconImage)
                if UserDefaults.standard.value(forKey: purchaseResults[indexPath.row].ApplicationName) != nil {
                    cell.downloadButton.setTitle("열기", for: .normal)
                } else {
                    cell.downloadButton.setTitle("받기", for: .normal)
                    cell.downloadButton.tag = indexPath.row
                    cell.downloadButton.addTarget(self, action: #selector(downloadButtonClicked(sender:)), for: .touchUpInside)
                    if let day = getDay(day: purchaseResults[indexPath.row].DownloadAt) {
                        cell.dateLabel.text = "\(day)일 전"
                    } else {
                        cell.dateLabel.text = ""
                    }
                }
            }
        case 1:
            if isFiltering {
                cell.appNameLabel.text = filteredResultsNotInPhone[indexPath.row].ApplicationName
                cell.appIconImageView.setImage(url: filteredResultsNotInPhone[indexPath.row].IconImage)
                if UserDefaults.standard.value(forKey: filteredResultsNotInPhone[indexPath.row].ApplicationName) != nil {
                    cell.downloadButton.setTitle("열기", for: .normal)
                } else {
                    cell.downloadButton.setTitle("받기", for: .normal)
                    cell.downloadButton.tag = indexPath.row
                    cell.downloadButton.addTarget(self, action: #selector(downloadButtonClicked(sender:)), for: .touchUpInside)
                    if let day = getDay(day: filteredResultsNotInPhone[indexPath.row].DownloadAt) {
                        cell.dateLabel.text = "\(day)일 전"
                    } else {
                        cell.dateLabel.text = ""
                    }
                }
            } else {
                cell.appNameLabel.text = purchaseResultsNotInPhone[indexPath.row].ApplicationName
                cell.appIconImageView.setImage(url: purchaseResultsNotInPhone[indexPath.row].IconImage)
                if UserDefaults.standard.value(forKey: purchaseResultsNotInPhone[indexPath.row].ApplicationName) != nil {
                    cell.downloadButton.setTitle("열기", for: .normal)
                } else {
                    cell.downloadButton.setTitle("받기", for: .normal)
                    cell.downloadButton.tag = indexPath.row
                    cell.downloadButton.addTarget(self, action: #selector(downloadButtonClicked(sender:)), for: .touchUpInside)
                    if let day = getDay(day: purchaseResultsNotInPhone[indexPath.row].DownloadAt) {
                        cell.dateLabel.text = "\(day)일 전"
                    } else {
                        cell.dateLabel.text = ""
                    }
                }
            }
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var applicationId: Int?
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            if isFiltering {
                applicationId = filteredResults[indexPath.row].ApplicationId
            } else {
                applicationId = purchaseResults[indexPath.row].ApplicationId
            }
        case 1:
            if isFiltering {
                applicationId = filteredResultsNotInPhone[indexPath.row].ApplicationId
            } else {
                applicationId = purchaseResultsNotInPhone[indexPath.row].ApplicationId
            }
        default:
            break
        }
        
        if let id = applicationId {
            let applicationDetailViewController = AppDetailViewController(id)
            self.navigationController?.pushViewController(applicationDetailViewController, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
