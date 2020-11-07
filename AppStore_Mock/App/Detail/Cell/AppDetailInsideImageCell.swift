//
//  AppDetailInsideImageCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/06.
//

import UIKit

class AppDetailInsideImageCell: UICollectionViewCell {
    var url: String? {
        didSet {
            guard let url = url else {
                return
            }
            
            imageView.setImage(url: url)
        }
    }

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 16
            imageView.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
