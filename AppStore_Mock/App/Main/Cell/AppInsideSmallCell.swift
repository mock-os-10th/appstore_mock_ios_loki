//
//  AppInsideSmallCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/02.
//

import UIKit

class AppInsideSmallCell: UICollectionViewCell {
    var data: AppSmallResult? {
        didSet {
            guard let data = data else {
                return
            }
            appNameLabel.text = data.ApplicationName
            appDetailLabel.text = data.Summary
            appIconImageView.setImage(url: data.IconImage)
            if data.InAppPurchase == "Y" {
                insideAppDownLoadLabel.isHidden = true
            }
        }
    }

    @IBOutlet weak var appIconImageView: UIImageView! {
        didSet {
            appIconImageView.layer.cornerRadius = 8
            appIconImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appDetailLabel: UILabel!
    @IBOutlet weak var insideAppDownLoadLabel: UILabel!
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

}
