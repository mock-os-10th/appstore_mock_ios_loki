//
//  AppDetailInfoTableViewCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/06.
//

import UIKit

class AppDetailInfoTableViewCell: UITableViewCell {
    var data: [(String, String)]?

    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "AppDetailInfoTableViewSmallCell", bundle: Bundle.main), forCellReuseIdentifier: "AppDetailInfoTableViewSmallCell")
        self.tableView.register(UINib(nibName: "AppDetailInfoTableViewLargeCell", bundle: Bundle.main), forCellReuseIdentifier: "AppDetailInfoTableViewLargeCell")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        self.tableView.allowsSelection = false
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.reloadData()
    }

}

extension AppDetailInfoTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = data else {
            return tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        }
        if data[indexPath.row].0 == "언어" || data[indexPath.row].0 == "호환성" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailInfoTableViewLargeCell") as? AppDetailInfoTableViewLargeCell {
                
                cell.keywordLabel.text = data[indexPath.row].0
                cell.detailLabel.text = data[indexPath.row].1
                
                return cell
             }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailInfoTableViewSmallCell") as? AppDetailInfoTableViewSmallCell {
                
                cell.keywordLabel.text = data[indexPath.row].0
                cell.detailLabel.text = data[indexPath.row].1
                
                return cell
            }
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
    }
}
