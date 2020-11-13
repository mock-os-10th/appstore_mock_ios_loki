//
//  PurchaseListTableViewCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/13.
//

import UIKit

class PurchaseListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var appIconImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        appIconImageView.layer.cornerRadius = 8
        appIconImageView.clipsToBounds = true
        downloadButton.layer.cornerRadius = 16
        downloadButton.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
