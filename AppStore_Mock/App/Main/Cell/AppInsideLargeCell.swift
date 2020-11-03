//
//  appInsideLargeCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/02.
//

import UIKit

class AppInsideLargeCell: UICollectionViewCell {
    var data: AppLargeResult? {
        didSet {
            guard let data = data else {
                return
            }
            appKeywordLabel.text = data.Category
            appNameLabel.text = data.ApplicationName
            appDetailLabel.text = data.Summary
            appImage.setImage(url: data.thumbnailUrl)
        }
    }
    
     
    
    @IBOutlet var appKeywordLabel: UILabel!
    @IBOutlet var appNameLabel: UILabel!
    @IBOutlet var appDetailLabel: UILabel!
    @IBOutlet var appImage: UIImageView! {
        didSet {
            appImage.layer.cornerRadius = 6
            appImage.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
