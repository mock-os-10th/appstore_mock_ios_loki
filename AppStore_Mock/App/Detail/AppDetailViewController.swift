//
//  AppDetailViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/05.
//

import UIKit

class AppDetailViewController: UIViewController {
    
    var applicationId: Int?
    
    init(_ applicationId: Int) {
        self.applicationId = applicationId
        
        super.init(nibName: "AppDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var appDetailResult: AppDetailResult? {
        didSet {
            guard let result = appDetailResult else {
                return
            }
            
            ageLabel.text = "\(result.Ages)+"
            devNameLabel.text = result.DevName
            categoryLabel.text = result.Category
            languageLabel.text = result.Word
            languageCountLabel.text = "+ \(result.WordCount - 1)개 언어"
        }
    }

    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var devNameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var languageCountLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "AppDetailImagesCell", bundle: nil), forCellWithReuseIdentifier: "AppDetailImagesCell")
        self.collectionView.register(UINib(nibName: "AppDetailInfoCell", bundle: nil), forCellWithReuseIdentifier: "AppDetailInfoCell")
        self.collectionView.register(UINib(nibName: "AppDetailInfoTableViewCell", bundle: nil), forCellWithReuseIdentifier: "AppDetailInfoTableViewCell")
        
        if let applicationId = applicationId {
            self.dismissIndicator()
            self.collectionView.reloadData()
        }
        
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

extension AppDetailViewController {
    func didRetrieveAppList(result: AppDetailResult) {
        self.appDetailResult = result
        self.dismissIndicator()
        self.collectionView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.dismissIndicator()
        self.presentAlert(title: message)
    }
}

extension AppDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let result = appDetailResult else {
            return UICollectionViewCell()
        }
        
        switch indexPath.row {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppDetailImagesCell", for: indexPath) as? AppDetailImagesCell {
                
                cell.images = result.ImageSet
                
                return cell
            }
        case 1:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppDetailInfoCell", for: indexPath) as? AppDetailInfoCell {
                cell.infoLabel.text = result.DetailInfo
                cell.devNameLabel.text = result.DevName
                
                return cell
            }
        case 2:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppDetailInfoTableViewCell", for: indexPath) as? AppDetailInfoTableViewCell {
                cell.data = [("제공자", result.DevName), ("크기", result.AppSize), ("카테고리", result.Category), ("호환성", result.Compatibility), ("언어", result.WordDetail), ("연령 등급", "\(result.Ages)+"), ("저작권", result.Copyright)]
                
                return cell
            }
        default:
            break
        }
        
        return UICollectionViewCell()
    }
    
    
}
