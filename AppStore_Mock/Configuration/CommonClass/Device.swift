//
//  Device.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/01.
//

import UIKit

// MARK: 디바이스의 크기, 여백 등의 정보를 담은 struct
// 참고하면 좋은 사이트 : https://kapeli.com/cheat_sheets/iOS_Design.docset/Contents/Resources/Documents/index
struct Device {
    // MARK: 노치 디자인인지 아닌지
    static var isNotch: Bool {
        return Double(UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? -1) > 0
    }
    
    // MARK: 상태바 높이
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    // MARK: 네비게이션 바 높이
    static var navigationBarHeight: CGFloat {
        return UINavigationController().navigationBar.frame.height
    }
    
    // MARK: 탭 바 높이
    static var tabBarHeight: CGFloat {
        return UITabBarController().tabBar.frame.height
    }
    
    // MARK: 디바이스의 위쪽 여백 (Safe Area 위쪽 여백)
    // ** 위쪽 여백의 전체 높이 : topInset + statusBarHeight + navigationBarHeight(존재하는 경우) **
    static var topInset: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }
    
    // MARK: 디바이스의 아래쪽 여백 (Safe Area 아래쪽 여백)
    // ** 아래쪽 여백의 전체 높이 : bottomInset + tabBarHeight(존재하는 경우) **
    static var bottomInset: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    }
}

