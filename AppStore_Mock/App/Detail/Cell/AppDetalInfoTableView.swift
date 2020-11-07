//
//  AppDetalInfoTableView.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/07.
//

import UIKit

class AppDetailInfoTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}
