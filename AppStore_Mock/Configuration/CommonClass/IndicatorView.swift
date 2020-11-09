//
//  IndicatorView.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/01.
//

import UIKit
import SnapKit

open class IndicatorView {
    static let shared = IndicatorView()
        
    let containerView = UIView()
    let activityIndicator = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    
    open func show() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        self.containerView.frame = window.frame
        self.containerView.center = window.center
        self.containerView.backgroundColor = .clear
        self.loadingLabel.text = "로드 중"
        self.containerView.addSubview(self.activityIndicator)
        self.containerView.addSubview(self.loadingLabel)
        
        UIApplication.shared.windows.first?.addSubview(self.containerView)
    }
    
    open func showIndicator() {
        self.containerView.backgroundColor = UIColor(hex: 0xffffff, alpha: 1)
        
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.activityIndicator.style = .medium
        self.activityIndicator.color = UIColor(hex: 0x808080)
        self.activityIndicator.center = self.containerView.center
        self.loadingLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.activityIndicator).offset(35)
        }
        
        self.loadingLabel.font = UIFont.systemFont(ofSize: 12)
        self.loadingLabel.textColor = UIColor(hex: 0x808080)
        
        self.activityIndicator.startAnimating()
    }
    
    open func dismiss() {
        self.activityIndicator.stopAnimating()
        self.containerView.removeFromSuperview()
    }
}
