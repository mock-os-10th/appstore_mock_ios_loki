//
//  AppDetailImagesCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/06.
//

import UIKit

class AppDetailImagesCell: UICollectionViewCell {
    
    var images: [AppDetailImage]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AppDetailInsideImageCell", bundle: nil), forCellWithReuseIdentifier: "AppDetailInsideImageCell")
        
    }

}

extension AppDetailImagesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppDetailInsideImageCell", for: indexPath) as? AppDetailInsideImageCell, let images = images else {
            
            return UICollectionViewCell()
        }
        
        cell.url = images[indexPath.row].AppImages
    
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.size.width - 150, height: 400)
    }
    
    
}
