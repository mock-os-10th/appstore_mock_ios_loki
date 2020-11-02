//
//  AppMainViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/01.
//

import UIKit

class AppMainViewController: UIViewController {
    var appLargeResponse: AppLargeResponse = AppLargeResponse(isSuccess: true, code: 100, result: [AppLargeResult(thumbnailUrl: "https://is2-ssl.mzstatic.com/image/thumb/Purple114/v4/d5/14/a7/d514a7fb-69e6-7519-e753-2527d12939f1/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationID: 1082345, ApplicationName: "어몽 어스", Summary: "마피아 게임", Category: "새로운 게임"), AppLargeResult(thumbnailUrl: "https://is2-ssl.mzstatic.com/image/thumb/Purple114/v4/d5/14/a7/d514a7fb-69e6-7519-e753-2527d12939f1/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationID: 1082345, ApplicationName: "어몽 어스", Summary: "마피아 게임", Category: "새로운 게임"), AppLargeResult(thumbnailUrl: "https://is2-ssl.mzstatic.com/image/thumb/Purple114/v4/d5/14/a7/d514a7fb-69e6-7519-e753-2527d12939f1/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationID: 1082345, ApplicationName: "어몽 어스", Summary: "마피아 게임", Category: "새로운 게임")])

    var appSmallResponses: [AppSmallResponse] = [AppSmallResponse(isSuccess: true, code: 100, result: [AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0)]), AppSmallResponse(isSuccess: true, code: 100, result: [AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0)]), AppSmallResponse(isSuccess: true, code: 100, result: [AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0), AppSmallResult(IconImage: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/b4/03/76/b40376f7-832f-1ce0-cd27-4c7e5b2870e4/AppIconHBOMAX-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png", ApplicationId: 1235123, ApplicationName: "HBO MAX", Summary: "비디오 앱", Price: 0)])]

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "AppLargeCell", bundle: nil), forCellWithReuseIdentifier: "AppLargeCell")
        self.collectionView.register(UINib(nibName: "AppSmallCell", bundle: nil), forCellWithReuseIdentifier: "AppSmallCell")
        self.collectionView.reloadData()
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

extension AppMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //0번째 row는 상단 광고 앱들, 1은 인기 앱 조회, 2는 따끈따끈한 업데이트, 3은 인기 금융 앱 조회
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppLargeCell", for: indexPath) as? AppLargeCell {
                cell.result = appLargeResponse.result
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppSmallCell", for: indexPath) as? AppSmallCell {
                cell.result = appSmallResponses[indexPath.row - 1].result
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: UIScreen.main.bounds.size.width, height: 300)
        }
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: 320)
    }
    
}
