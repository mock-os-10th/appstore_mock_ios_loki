//
//  UIImageView.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/02.
//

import UIKit

extension UIImageView {
    func setImage(url: String) {
        do {
            DispatchQueue.global().async {
                do {
                    if let realUrl = URL(string: url) {
                        let data = try Data(contentsOf: realUrl)
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
