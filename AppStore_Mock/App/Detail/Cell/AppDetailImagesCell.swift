//
//  AppDetailImagesCell.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/06.
//

import UIKit

class AppDetailImagesCell: UITableViewCell {
    
    var images: [AppDetailImage]?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AppDetailInsideImageCell", bundle: nil), forCellWithReuseIdentifier: "AppDetailInsideImageCell")
        
        let layout = SnappingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate = .fast
        collectionView.contentInset = .init(top: 0, left: 8, bottom: 0, right: 8)
        
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
        return CGSize(width: self.bounds.size.width / 2 + 60, height: 400)
    }
    
    
}
