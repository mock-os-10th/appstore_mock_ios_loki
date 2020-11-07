//
//  AppDetailUpdateInfoTableViewCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/08.
//

import UIKit

class AppDetailUpdateInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
