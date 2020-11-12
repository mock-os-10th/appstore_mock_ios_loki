//
//  AppSmallCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/02.
//

import UIKit
import SwiftKeychainWrapper


class AppSmallCell: UICollectionViewCell {
    var parentViewController: AppMainViewController?
    var result: [AppSmallResult]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var isRatingResult: Bool = false
    var category: String? {
        didSet {
            guard let category = category else {
                return
            }
            appCategoryLabel.text = category
        }
    }
    
    @IBOutlet weak var appCategoryLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AppInsideSmallCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AppInsideSmallCell")
        collectionView.register(UINib(nibName: "AppInsideRatingSmallCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AppInsideRatingSmallCell")
        let layout = SnappingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate = .fast
        collectionView.contentInset = .init(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    @objc func download(sender: UIButton) {
        guard let result = result else {
            return
        }
        if KeychainWrapper.standard.string(forKey: .jwt) == nil {
            let logInViewController = LogInViewController(appIconImageUrl: result[sender.tag].IconImage, applicationId: result[sender.tag].ApplicationId, appName: result[sender.tag].ApplicationName, devName: result[sender.tag].Summary, inAppPurchase: result[sender.tag].InAppPurchase, price: result[sender.tag].Price)
            logInViewController.sender = sender
            parentViewController?.present(logInViewController, animated: true, completion: nil)
        } else {
            let downloadViewController = DownloadViewController(appIconImageUrl: result[sender.tag].IconImage, applicationId: result[sender.tag].ApplicationId, appName: result[sender.tag].ApplicationName, devName: result[sender.tag].Summary, inAppPurchase: result[sender.tag].InAppPurchase, price: result[sender.tag].Price)
            downloadViewController.sender = sender
        
            downloadViewController.modalPresentationStyle = .overFullScreen
            parentViewController?.present(downloadViewController, animated: true, completion: nil)
        }
    }

}

extension AppSmallCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isRatingResult {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppInsideRatingSmallCell", for: indexPath) as? AppInsideRatingSmallCell, let result = result {
                cell.rating = String(indexPath.row + 1)
                cell.data = result[indexPath.row]
                cell.downloadButton.tag = indexPath.row
                if UserDefaults.standard.value(forKey: result[indexPath.row].ApplicationName) != nil {
                    cell.downloadButton.removeTarget(nil, action: nil, for: .allEvents)
                    cell.downloadButton.setTitle("열기", for: .normal)
                } else {
                    if result[indexPath.row].Price > 0 {
                        cell.downloadButton.setTitle(result[indexPath.row].Price.price, for: .normal)
                    } else {
                        cell.downloadButton.setTitle("받기", for: .normal)
                    }
                    cell.downloadButton.addTarget(self, action: #selector(download(sender:)), for: .touchUpInside)
                }
                return cell
            }
            
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppInsideSmallCell", for: indexPath) as? AppInsideSmallCell, let result = result {
                cell.data = result[indexPath.row]
                cell.downloadButton.tag = indexPath.row
                if UserDefaults.standard.value(forKey: result[indexPath.row].ApplicationName) != nil {
                    cell.downloadButton.removeTarget(nil, action: nil, for: .allEvents)
                    cell.downloadButton.setTitle("열기", for: .normal)
                } else {
                    if result[indexPath.row].Price > 0 {
                        cell.downloadButton.setTitle(result[indexPath.row].Price.price, for: .normal)
                    } else {
                        cell.downloadButton.setTitle("받기", for: .normal)
                    }
                    cell.downloadButton.addTarget(self, action: #selector(download(sender:)), for: .touchUpInside)
                }
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let result = result, let parentViewController = parentViewController else {
            return
        }
        let vc = AppDetailViewController(result[indexPath.row].ApplicationId)
        parentViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width - 20, height: 90)
    }
}
