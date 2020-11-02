//
//  AppSmallCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/02.
//

import UIKit

class AppSmallCell: UICollectionViewCell {
    var result: [AppSmallResult]?
    
    @IBOutlet weak var appCategoryLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AppInsideSmallCell", bundle: nil), forCellWithReuseIdentifier: "AppInsideSmallCell")
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppInsideSmallCell", for: indexPath) as? AppInsideSmallCell, let result = result else {
            return UICollectionViewCell()
        }
        
        cell.data = result[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width - 20, height: 90)
    }
}
