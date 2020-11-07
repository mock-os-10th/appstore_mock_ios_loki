//
//  AppDetailHeaderTableViewCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/08.
//

import UIKit

class AppDetailHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var appIconImageView: UIImageView! {
        didSet {
            appIconImageView.layer.cornerRadius = 18
            appIconImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appSummaryLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton! {
        didSet {
            downloadButton.layer.cornerRadius = 16
            downloadButton.layer.masksToBounds = true
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
