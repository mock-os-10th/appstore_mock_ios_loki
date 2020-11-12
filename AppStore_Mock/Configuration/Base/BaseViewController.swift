//
//  BaseViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/02.
//

import UIKit
import SnapKit
import SwiftKeychainWrapper

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
        accoutButton.addTarget(self, action: #selector(openAccountViewController), for: .touchUpInside)
        self.accoutButton.layer.cornerRadius = 15
        self.accoutButton.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setUpAccountButton()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
            make.height.width.equalTo(34)
        }
        
        setUpAccountButtonImage(url: KeychainWrapper.standard.string(forKey: .profileUrl))
        
    }
    
    func setUpAccountButtonImage(url: String?) {
        print("계정 버튼 이미지 변경")
        if let url = url {
            print("url 있음")
            print(KeychainWrapper.standard.string(forKey: .profileUrl))
            DispatchQueue.global().async {
                if let realUrl = URL(string: url) {
                    do {
                        let data = try Data(contentsOf: realUrl)
                        print("데이터까지 만들어짐")
                        DispatchQueue.main.async {
                            self.accoutButton.setImage(UIImage(data: data), for: .normal)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        } else {
            print("url 없음")
            self.accoutButton.setImage(UIImage(systemName: "person.circle"), for: .normal)
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
