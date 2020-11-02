//
//  SearchCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/02.
//

import UIKit

class SearchCell: UICollectionViewCell {
    @IBOutlet weak var appIcon: UIImageView! {
        didSet {
            appIcon.layer.cornerRadius = 12
            appIcon.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var getButton: UIButton! {
        didSet {
            getButton.layer.cornerRadius = 16
            getButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appCategoryLabel: UILabel!
    @IBOutlet weak var appRatingLabel: UILabel!
    

    @IBOutlet weak var previewImage1: UIImageView! {
        didSet {
            previewImage1.layer.cornerRadius = 8
            previewImage1.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var previewImage2: UIImageView! {
        didSet {
            previewImage2.layer.cornerRadius = 8
            previewImage2.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var previewImage3: UIImageView! {
        didSet {
            previewImage3.layer.cornerRadius = 8
            previewImage3.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
