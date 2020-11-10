//
//  TodayDetailImageCollectionViewCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/10.
//

import UIKit

class TodayDetailImageCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }

}
