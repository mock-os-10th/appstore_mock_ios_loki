//
//  BaseViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/02.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    let accoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        setUpAccountButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpAccountButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dismissAccoutButton()
    }
    func setUpAccountButton() {
        guard let navigationBar = self.navigationController?.navigationBar else {
            return
        }
        accoutButton.setImage(UIImage(systemName: "person.circle"), for: .normal)
        accoutButton.tag = 1
        navigationBar.addSubview(accoutButton)

        accoutButton.contentVerticalAlignment = .fill
        accoutButton.contentHorizontalAlignment = .fill
        accoutButton.imageView?.contentMode = .scaleToFill
        accoutButton.clipsToBounds = true
        accoutButton.snp.makeConstraints { (make) in
            make.right.equalTo(navigationBar.snp.right).offset(-16)
            make.bottom.equalTo(navigationBar.snp.bottom).offset(-12)
            make.height.width.equalTo(35)
        }
    }
    
    func dismissAccoutButton() {
        accoutButton.removeFromSuperview()
    }
}

extension BaseViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let navigationBarHeight = navigationController?.navigationBar.frame.height else {
            return
        }
        
        if navigationBarHeight > 44 {
            accoutButton.isHidden = false
        } else {
            accoutButton.isHidden = true
        }
    }
}
