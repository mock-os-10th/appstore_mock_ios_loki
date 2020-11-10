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
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var appView: UIView!
    @IBOutlet weak var appIconImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appSummaryLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var inAppPurchaseLabel: UILabel!
    
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
        
        
        view.clipsToBounds = true
        contentScrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        
        self.appIconImageView.layer.cornerRadius = 8
        self.appIconImageView.clipsToBounds = true
        
        self.downloadButton.layer.cornerRadius = 16
        self.downloadButton.clipsToBounds = true
    
        
        if let result = result {
            headerImageView.setImage(url: result.ThumbnailUrl)
            detailLabel.text = result.DetailInfo
            appIconImageView.setImage(url: result.IconImage)
            appNameLabel.text = result.ApplicationName
            appSummaryLabel.text = result.Summary
            
            if result.Price > 0 {
                downloadButton.setTitle("₩\(result.Price)", for: .normal)
            }
            
            if result.InAppPurchase == "N" {
                inAppPurchaseLabel.isHidden = true
            }
        }
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pushToAppDetailViewController))
        self.appView.addGestureRecognizer(gesture)
        
        let _ = dismissHandler
        
        headerViewHeightConstraint.constant = UIScreen.main.bounds.width * 1.272 - 10
        
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
        self.imageCollectionView.register(UINib(nibName: "TodayDetailImageCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "TodayDetailImageCollectionViewCell")
        
        let layout = SnappingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        self.imageCollectionView.collectionViewLayout = layout
        self.imageCollectionView.decelerationRate = .fast
        self.imageCollectionView.contentInset = .init(top: 0, left: 8, bottom: 0, right: 8)
        
        self.imageCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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

extension TodayDetailViewController {
    @objc func pushToAppDetailViewController() {
        guard let result = result else {
            return
        }
        let appDetailViewController = AppDetailViewController(result.ApplicationId)
        self.navigationController?.pushViewController(appDetailViewController, animated: true)
    }
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

extension TodayDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result?.ImageSet.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayDetailImageCollectionViewCell", for: indexPath) as? TodayDetailImageCollectionViewCell, let result = result else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
        }
        
        cell.imageView.setImage(url: result.ImageSet[indexPath.row].AppImages)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width / 2 - 20, height: 300)
    }
    
}
