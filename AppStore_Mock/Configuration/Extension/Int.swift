//
//  Int.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/08.
//

import Foundation

extension Int {
    var beforedays: String {
        if self / 365 > 0 {
            return "\(self / 365)년 전"
        } else if self / 30 > 0 {
            return "\(self / 30)달 전"
        } else if self / 7 > 0 {
            return "\(self / 7)주 전"
        } else {
            return "\(self)일 전"
        }
    }
}
