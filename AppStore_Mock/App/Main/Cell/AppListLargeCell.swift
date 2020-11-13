//
//  AppListLargeCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/13.
//

import UIKit

class AppListLargeCell: UITableViewCell {

    @IBOutlet weak var appIconImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appDetailLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var inAppPurchaseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.appIconImageView.layer.cornerRadius = 16
        self.appIconImageView.clipsToBounds = true
        
        self.downloadButton.layer.cornerRadius = 16
        self.downloadButton.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
