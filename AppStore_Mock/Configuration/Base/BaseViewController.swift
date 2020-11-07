//
//  BaseViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/02.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    let accoutButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "person.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageView?.contentMode = .scaleToFill
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setUpAccountButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setUpAccountButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        dismissAccoutButton()
    }
    func setUpAccountButton() {
        guard let navigationBar = self.navigationController?.navigationBar else {
            return
        }
        navigationBar.addSubview(accoutButton)
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
