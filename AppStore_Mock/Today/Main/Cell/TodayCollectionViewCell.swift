//
//  TodayCollectionViewCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/09.
//

import UIKit
import AppstoreTransition

class TodayCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
    }
    
    
}
