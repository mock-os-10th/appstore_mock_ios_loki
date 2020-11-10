//
//  SearchMainViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/01.
//

import UIKit

class SearchMainViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchResults = [SearchResult]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "검색"
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 350
        self.tableView.register(UINib(nibName: "SearchTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "SearchTableViewCell")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
    }
    
    override func setUpAccountButton() {
        guard let navigationBar = self.navigationController?.navigationBar else {
            return
        }
        navigationBar.addSubview(accoutButton)
        accoutButton.snp.makeConstraints { (make) in
            make.right.equalTo(navigationBar.snp.right).offset(-16)
            make.bottom.equalTo(navigationBar.snp.bottom).offset(-65)
            make.height.width.equalTo(34)
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

extension SearchMainViewController {
    func didRetrieveSearchResults(result: [SearchResult]) {
        searchResults.append(contentsOf: result)
        print("검색 완료")
        self.dismissIndicator()
        self.tableView.reloadData()
    }
    
    func failedToSearchRequest(message: String) {
        self.dismissIndicator()
        self.presentAlert(title: message)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let navigationBarHeight = navigationController?.navigationBar.frame.height else {
            return
        }
        
        if navigationBarHeight > 44 {
            if !searchController.isActive {
                accoutButton.isHidden = false
            }
        } else {
            if !searchController.isActive {
                accoutButton.isHidden = true
            }
        }
    }
}

extension SearchMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        }
        
        cell.appIconImageView.setImage(url: searchResults[indexPath.row].IconImage)
        cell.appNameLabel.text = searchResults[indexPath.row].ApplicationName
        cell.appCategoryLabel.text = searchResults[indexPath.row].Summary
        if searchResults[indexPath.row].Price > 0 {
            cell.downloadButton.setTitle("₩\(searchResults[indexPath.row].Price)", for: .normal)
        }
        if searchResults[indexPath.row].InAppPurchase == "N" {
            cell.inAppPurchaseLabel.isHidden = true
        }
        cell.previewImageView1.setImage(url: searchResults[indexPath.row].ImageSet[0].AppImages)
        cell.previewImageView2.setImage(url: searchResults[indexPath.row].ImageSet[1].AppImages)
        cell.previewImageView3.setImage(url: searchResults[indexPath.row].ImageSet[2].AppImages)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDetailViewController = AppDetailViewController(searchResults[indexPath.row].ApplicationId)
        
        self.navigationController?.pushViewController(appDetailViewController, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension SearchMainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        return
    }
}

extension SearchMainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        print("search button clicked")
        self.showIndicator()
        if let searchKeyword = searchBar.text, !searchKeyword.isEmpty {
            SearchDataManager.shared.getSearchResults(searchKeyword: searchKeyword, viewController: self)
        } else {
            self.presentAlert(title: "검색어를 입력해주세요.")
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        accoutButton.isHidden = false
        searchController.isActive = false
        searchResults.removeAll()
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        accoutButton.isHidden = true
    }
}
