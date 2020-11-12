//
//  TodayMainViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/01.
//

import UIKit
import SwiftKeychainWrapper

class TodayMainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var todayResults = [TodayResult]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "투데이"
        
        self.view.backgroundColor = UIColor.todayBackgroundColor
        collectionView.backgroundColor = UIColor.todayBackgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TodayCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "TodayCollectionViewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
        collectionView.register(UINib(nibName: "TodayHeaderView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TodayHeaderView")
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let height = UIScreen.main.bounds.height / 2 + 80
            let width = UIScreen.main.bounds.width - 40
            layout.itemSize = CGSize(width:width, height: height)
            layout.minimumLineSpacing = 30
        }
        
        self.showIndicator()
        TodayDataManager.shared.getAdvertisements(viewController: self)
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

extension TodayMainViewController {
    func didRetrieveAdvertisements(result: [TodayResult]) {
        self.todayResults.append(contentsOf: result)
        self.dismissIndicator()
        self.collectionView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.dismissIndicator()
        self.presentAlert(title: message)
    }
}

extension TodayMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCollectionViewCell", for: indexPath) as? TodayCollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
        }
        
        cell.backgroundImageView.setImage(url: todayResults[indexPath.row].ThumbnailUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let todayDetailViewController = TodayDetailViewController(todayResults[indexPath.row])
        
        let todayDetailNavigationController = UINavigationController(rootViewController: todayDetailViewController)
    
        
        todayDetailNavigationController.modalPresentationStyle = .custom
        
        self.present(todayDetailNavigationController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TodayHeaderView", for: indexPath) as! TodayHeaderView
            headerView.dayLabel.text = Date().currentDay
            headerView.accountButton.addTarget(self, action: #selector(openAccountViewController), for: .touchUpInside)
            if let url = KeychainWrapper.standard.string(forKey: .profileUrl) {
                print(url)
                DispatchQueue.global().async {
                    if let realUrl = URL(string: url) {
                        do {
                            let data = try Data(contentsOf: realUrl)
                            print("투데이에서 이미지 데이터 만들어짐")
                            DispatchQueue.main.async {
                                headerView.accountButton.setImage(UIImage(data: data), for: .normal)
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            } else {
                headerView.accountButton.setImage(UIImage(systemName: "person.circle"), for: .normal)
            }
            
            
            return headerView
        default:
            break
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}


