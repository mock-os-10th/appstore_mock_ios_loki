//
//  AccountMainViewController.swift
//  AppStore_Mock
//
//  Created by Seok on 2020/11/11.
//

import UIKit
import SwiftKeychainWrapper
import KakaoSDKAuth
import KakaoSDKUser

class AccountMainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var todayVC: TodayMainViewController?
    var baseVC: BaseViewController?
    
    init() {
        super.init(nibName: "AccountMainViewController", bundle: Bundle.main)
    }
    
    init(todayVC: TodayMainViewController) {
        super.init(nibName: "AccountMainViewController", bundle: Bundle.main)
        self.todayVC = todayVC
    }
    
    init(baseVC: BaseViewController) {
        super.init(nibName: "AccountMainViewController", bundle: Bundle.main)
        self.baseVC = baseVC
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "계정"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(dismissAcountViewController))

        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        tableHeaderView.backgroundColor = .backgroundColor
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.tableHeaderView = tableHeaderView
        self.tableView.backgroundColor = .backgroundColor
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        
        self.activityIndicator.hidesWhenStopped = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
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

extension AccountMainViewController {
    @objc func dismissAcountViewController() {
        print("완료 버튼 클릭")
        if let todayVC = todayVC {
            print("투데이에서 만들어진 계정 컨트롤러 제거")
            self.dismiss(animated: true) {
                todayVC.collectionView.reloadData()
            }
        } else if let baseVC = baseVC {
            print("기본에서 만들어진 계정 컨트롤러 제거")
            self.dismiss(animated: true) {
                baseVC.setUpAccountButtonImage(url: KeychainWrapper.standard.string(forKey: .profileUrl))
            }
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func didRetrieveLogInResult(result: LogInResult) {
        self.dismissIndicator()
        KeychainWrapper.standard.set(result.jwt, forKey: "jwt")
        print("앱 내 로그인 성공")
        self.tableView.reloadData()
    }
    
    func failedToLoginResult(message: String) {
        self.dismissIndicator()
        self.presentAlert(title: message)
    }
    
    func finishLogOut() {
        self.tableView.reloadData()
        self.dismissNavigationBarIndicator()
    }
    
    func failedToLogOut(message: String) {
        self.dismissNavigationBarIndicator()
        self.presentAlert(title: message)
    }
    
    func logOutButtonClicked() {
        self.showNavigationBarIndicator()
        LogInDataManager.shared.logOut(viewController: self)
    }
    
    func showNavigationBarIndicator() {
        activityIndicator.color = .gray
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setLeftBarButton(barButton, animated: true)
        activityIndicator.startAnimating()
    }
    
    func dismissNavigationBarIndicator() {
        activityIndicator.stopAnimating()
        self.navigationItem.setLeftBarButton(nil, animated: true)
    }
}

extension AccountMainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if KeychainWrapper.standard.string(forKey: .jwt) == nil {
            return 1
        } else {
            return 5
        }
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if KeychainWrapper.standard.string(forKey: .jwt) == nil {
            var cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
            cell.textLabel?.text = "로그인"
            cell.textLabel?.textColor = .systemBlue
                
            return cell
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
            
            switch indexPath.section {
            case 0:
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
                if let email = KeychainWrapper.standard.string(forKey: .email) {
                    cell.textLabel?.text = email
                    cell.textLabel?.textColor = .black
                }
                if let name = KeychainWrapper.standard.string(forKey: .name) {
                    cell.detailTextLabel?.text = name
                    cell.detailTextLabel?.textColor = .systemGray
                }
            case 1:
                cell.textLabel?.text = "구입 항목"
                cell.textLabel?.textColor = .black
                cell.accessoryType = .disclosureIndicator
            case 2:
                cell.textLabel?.text = "기프트 카드 또는 코드 교환"
                cell.textLabel?.textColor = .systemBlue
            case 3:
                cell.textLabel?.text = "개인 맞춤화 추천"
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.textColor = .black
            case 4:
                cell.textLabel?.text = "로그아웃"
                cell.textLabel?.textColor = .systemBlue
            default:
                break
            }
            
            return cell
        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .backgroundColor
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if KeychainWrapper.standard.string(forKey: .jwt) == nil {
                LogInDataManager.shared.logIn(viewController: self)
            }
        case 1:
            let purchaseViewController = PurchaseListViewController()
            self.navigationController?.pushViewController(purchaseViewController, animated: true)
        case 4:
            logOutButtonClicked()
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
