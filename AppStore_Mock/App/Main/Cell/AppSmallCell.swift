//
//  AppSmallCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/02.
//

import UIKit

class AppSmallCell: UICollectionViewCell {
    var parentViewController: AppMainViewController?
    var result: [AppSmallResult]?
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
        collectionView.register(UINib(nibName: "AppInsideSmallCell", bundle: nil), forCellWithReuseIdentifier: "AppInsideSmallCell")
        collectionView.register(UINib(nibName: "AppInsideRatingSmallCell", bundle: nil), forCellWithReuseIdentifier: "AppInsideRatingSmallCell")
        let layout = SnappingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate = .fast
        collectionView.contentInset = .init(top: 0, left: 8, bottom: 0, right: 8)
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
                return cell
            }
            
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppInsideSmallCell", for: indexPath) as? AppInsideSmallCell, let result = result {
                cell.data = result[indexPath.row]
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
