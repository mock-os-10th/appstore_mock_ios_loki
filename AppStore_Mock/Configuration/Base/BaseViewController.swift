//
//  BaseViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/02.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation bar
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.view.backgroundColor = .white
    }
}
