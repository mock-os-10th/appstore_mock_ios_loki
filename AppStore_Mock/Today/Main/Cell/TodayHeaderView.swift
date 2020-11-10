//
//  TodayHeaderView.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/10.
//

import UIKit

class TodayHeaderView: UICollectionReusableView {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var accountButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        accountButton.contentVerticalAlignment = .fill
        accountButton.contentHorizontalAlignment = .fill
        accountButton.imageView?.contentMode = .scaleToFill
        accountButton.clipsToBounds = true
        self.backgroundColor = UIColor.todayBackgroundColor
    }
    
}
