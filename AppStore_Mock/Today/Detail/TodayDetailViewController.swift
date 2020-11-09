//
//  TodayDetailViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/10.
//

import UIKit
import AppstoreTransition

class TodayDetailViewController: UIViewController {
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    var result: TodayResult?
    
    init(_ result: TodayResult) {
        self.result = result
        
        super.init(nibName: "TodayDetailViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let result = result {
            headerImageView.setImage(url: result.ThumbnailUrl)
        }
        
        view.clipsToBounds = true
        contentScrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        
        let _ = dismissHandler
        
        headerViewHeightConstraint.constant = UIScreen.main.bounds.width * 1.272 - 16.0
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TodayDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = scrollView.contentOffset.y > 100
        
        dismissHandler.scrollViewDidScroll(scrollView)
    }
}

extension TodayDetailViewController: CardDetailViewController {
    var cardContentView: UIView {
        return headerView
    }
    
    var scrollView: UIScrollView {
        return contentScrollView
    }
}
