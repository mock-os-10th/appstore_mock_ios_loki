//
//  SearchTableViewCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/10.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var appIconImageView: UIImageView! {
        didSet {
            appIconImageView.layer.cornerRadius = 12
            appIconImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appCategoryLabel: UILabel!
    
    @IBOutlet weak var downloadButton: UIButton! {
        didSet {
            downloadButton.layer.cornerRadius = 16
            downloadButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var previewImageView1: UIImageView! {
        didSet {
            previewImageView1.layer.cornerRadius = 8
            previewImageView1.clipsToBounds = true
        }
    }
    @IBOutlet weak var previewImageView2: UIImageView! {
        didSet {
            previewImageView2.layer.cornerRadius = 8
            previewImageView2.clipsToBounds = true
        }
    }
    @IBOutlet weak var previewImageView3: UIImageView! {
        didSet {
            previewImageView3.layer.cornerRadius = 8
            previewImageView3.clipsToBounds = true
        }
    }
    @IBOutlet weak var inAppPurchaseLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
