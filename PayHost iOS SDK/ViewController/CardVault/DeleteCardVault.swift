//
//  DeleteCardVault.swift
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
class DeleteCardVault: UIViewController {
    
    
    @IBOutlet weak var paygateId: UITextField!
    @IBOutlet weak var encryptionkey: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    var accounStr : AccountXML?
    
    
    @IBOutlet weak var requestTextvw: UIPlaceHolderTextView!
    @IBOutlet weak var responseTextvw: UIPlaceHolderTextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpview()
    }
    
    //MARK: --------------SetUp VIew------------------------
    
    func setUpview() {
        self.title = "Delete Vault"
        setMenuButton()
        setTextViewShdow(requestTextvw)
        setTextViewShdow(responseTextvw)
    }
    
    //MARK---------------------------------------Delete card Value----------------------------------
    @IBAction func docardValueAction(_ sender: Any) {
        Deletcard()
    }
    func Deletcard(){
        
        do{
            let decoder = JSONDecoder()
            let dic = ["paygateId":paygateId.text!,"password":encryptionkey.text!]
            let jsonDataAcc = try JSONSerialization.data(withJSONObject:dic, options: .prettyPrinted)
            accounStr = try decoder.decode(AccountXML.self, from: jsonDataAcc)
            print(accounStr?.soapStr ?? "error")
        }
        catch{
        }
        let valtooshow = """
        \(accounStr!.soapStr!)
        <ns:VaultId>\(cardNumber.text ?? "")</ns:VaultId>
        """
        print(valtooshow)
        let qucard = DeleteCardMessage(soapvalue: valtooshow)
        print(qucard.soapvalue)
        self.requestTextvw.text = qucard.soapvalue
        
        WebServiceHandler().PostRequestWithXml(parms: qucard.soapvalue, Url: APIConstants.CardVault, headers: APIConstants.headers, Success: {(responseObject,ResponseString) -> () in
            
            if(ResponseString.contains("Completed")){
                DispatchQueue.main.sync {
                    self.responseTextvw.text = ResponseString
                }
                print("Success")
            }
        }, Failure: {(error) -> () in
            print(error!.description)
        },showLoader: true, hideLoader: true)
    }
    
    
}
