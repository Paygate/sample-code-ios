//
//  MenuViewController.swift
//  PayHost iOS SDK
//
//  Author: PayGate (Pty) Ltd
//  Author URI: https://www.paygate.co.za/
//  Developer: App Inlet (Pty) Ltd
//  Developer URI: https://www.appinlet.com/
//
//  Copyright: © 2018 PayGate (Pty) Ltd.
//  License: GNU General Public License v3.0
//  License URI: http://www.gnu.org/licenses/gpl-3.0.html
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var menutableview: UITableView!
    
    var menuName = ["Card Vault","Delete Vault","Lookup Vault"]
    var followUpReq = ["Query","Void","Refund","Settlement"]
    var SectionArray = ["Single Vault Request","Follow Up Request","Message types Request"]
    var menuName2 = ["Card Payment","Web Payment","Token Payment"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "HeaderMenuCell", bundle: nil)
        self.menutableview.register(nibName, forHeaderFooterViewReuseIdentifier: "headercell")
        let HEIGHT_VIEW = 40
        
        menutableview.tableHeaderView?.frame.size = CGSize(width:menutableview.frame.width, height: CGFloat(HEIGHT_VIEW))
        self.menutableview.tableHeaderView = self.menutableview.tableHeaderView;
        menutableview.layoutIfNeeded()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}
extension MenuViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(section)
        if(section == 0){
            return menuName.count
        }
        else if(section == 1){
            return followUpReq.count
        }
        else{
            return menuName2.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menucell", for: indexPath)
        let namelbl:UILabel = cell.viewWithTag(10) as! UILabel
        if(indexPath.section == 0){
            namelbl.text = menuName[indexPath.row]
        }
        else if(indexPath.section == 1){
            namelbl.text = followUpReq[indexPath.row]
        }
        else{
            namelbl.text = menuName2[indexPath.row]
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: StoryboardID.CardPayment, bundle: nil)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let vc  = mainStoryBoard.instantiateViewController(withIdentifier: "CardvaultBase") as! CardvaultBase
                let nav = UINavigationController(rootViewController: vc)
                nav.setViewControllers([vc], animated:true)
                self.revealViewController().setFront(nav, animated: true)
                self.revealViewController().pushFrontViewController(nav, animated: true)
            case 1:
                let vc  = mainStoryBoard.instantiateViewController(withIdentifier: "DeleteCardVault") as! DeleteCardVault
                let nav = UINavigationController(rootViewController: vc)
                nav.setViewControllers([vc], animated:true)
                self.revealViewController().setFront(nav, animated: true)
                self.revealViewController().pushFrontViewController(nav, animated: true)
            case 2:
                let vc  = mainStoryBoard.instantiateViewController(withIdentifier: "LookupVaultView") as! LookupVaultView
                let nav = UINavigationController(rootViewController: vc)
                nav.setViewControllers([vc], animated:true)
                self.revealViewController().setFront(nav, animated: true)
                self.revealViewController().pushFrontViewController(nav, animated: true)
            default:
                print("default")
            }
        case 1:
            switch indexPath.row {
            case 0:
                let vc  = mainStoryBoard.instantiateViewController(withIdentifier: "FollowRequestQueryView") as! FollowRequestQueryView
                vc.viewType = "query"
                let nav = UINavigationController(rootViewController: vc)
                nav.setViewControllers([vc], animated:true)
                self.revealViewController().setFront(nav, animated: true)
                self.revealViewController().pushFrontViewController(nav, animated: true)
            case 1:
                let vc  = mainStoryBoard.instantiateViewController(withIdentifier: "FollowRequestQueryView") as! FollowRequestQueryView
                vc.viewType = "void"
                let nav = UINavigationController(rootViewController: vc)
                nav.setViewControllers([vc], animated:true)
                self.revealViewController().setFront(nav, animated: true)
                self.revealViewController().pushFrontViewController(nav, animated: true)
            case 2:
                let vc  = mainStoryBoard.instantiateViewController(withIdentifier: "FollowRequestQueryView") as! FollowRequestQueryView
                vc.viewType = "refund"
                let nav = UINavigationController(rootViewController: vc)
                nav.setViewControllers([vc], animated:true)
                self.revealViewController().setFront(nav, animated: true)
                self.revealViewController().pushFrontViewController(nav, animated: true)
            case 3:
                let vc  = mainStoryBoard.instantiateViewController(withIdentifier: "FollowRequestQueryView") as! FollowRequestQueryView
                vc.viewType = "settle"
                let nav = UINavigationController(rootViewController: vc)
                nav.setViewControllers([vc], animated:true)
                self.revealViewController().setFront(nav, animated: true)
                self.revealViewController().pushFrontViewController(nav, animated: true)
                
            default:
                print("default")
            }
        case 2:
            switch indexPath.row {
            case 0:
                let vc  = mainStoryBoard.instantiateViewController(withIdentifier: "SingleWebPayment") as! SingleWebPayment
                vc.viewType = "card"
                let nav = UINavigationController(rootViewController: vc)
                nav.setViewControllers([vc], animated:true)
                self.revealViewController().setFront(nav, animated: true)
                self.revealViewController().pushFrontViewController(nav, animated: true)
            case 1:
                let vc  = mainStoryBoard.instantiateViewController(withIdentifier: "SingleWebPayment") as! SingleWebPayment
                vc.viewType = "web"
                let nav = UINavigationController(rootViewController: vc)
                nav.setViewControllers([vc], animated:true)
                self.revealViewController().setFront(nav, animated: true)
                self.revealViewController().pushFrontViewController(nav, animated: true)
            case 2:
                let vc  = mainStoryBoard.instantiateViewController(withIdentifier: "SingleWebPayment") as! SingleWebPayment
                vc.viewType = "token"
                let nav = UINavigationController(rootViewController: vc)
                nav.setViewControllers([vc], animated:true)
                self.revealViewController().setFront(nav, animated: true)
                self.revealViewController().pushFrontViewController(nav, animated: true)
                
            default:
                print("default")
            }
            
        default:
            print("default")
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headercell") as! HeaderMenuCell
        headerCell.backgroundColor = UIColor.cyan
        
        headerCell.titleLabel.text = SectionArray[section];
        
        return headerCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 45
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
}
