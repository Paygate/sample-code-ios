//
//  CardvaultBase.swift
//  PayHost iOS SDK
//
//  Author: PayGate (Pty) Ltd
//  Author URI: https://www.paygate.co.za/
//  Developer: App Inlet (Pty) Ltd
//  Developer URI: https://www.appinlet.com/
//
//  Copyright: © 2020 PayGate (Pty) Ltd.
//  License: GNU General Public License v3.0
//  License URI: http://www.gnu.org/licenses/gpl-3.0.html
//

import UIKit
import KRProgressHUD
class CardvaultBase: UIViewController {
    
    @IBOutlet weak var paygateId: UITextField!
    @IBOutlet weak var encryptionkey: UITextField!
    @IBOutlet weak var cardExpdate: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    var accounStr : AccountXML?
    @IBOutlet weak var requestTextvw: UIPlaceHolderTextView!
    @IBOutlet weak var responseTextvw: UIPlaceHolderTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 12.0, *) {
            switch UIScreen.main.traitCollection.userInterfaceStyle {
            case .dark: // put your dark mode code here
                self.view.backgroundColor = .black
            case .light:
                self.view.backgroundColor = .white
                
                
            case .unspecified: break
            @unknown default:
                break
            }
        }
        
        self.setUpview()
    }
    
    //MARK: --------------SetUp VIew------------------------
    
    func setUpview() {
        self.title = "Card Vault"
        
        
        setMenuButton()
        setTextViewShdow(requestTextvw)
        setTextViewShdow(responseTextvw)
    }
    @IBAction func docardValueAction(_ sender: Any) {
        setCardVault()
    }
    //MARk:--------------------------------------Set Card Valut--------------------
    func setCardVault(){
        
        do{
            let decoder = JSONDecoder()
            let dic = ["paygateId":paygateId.text!,"password":encryptionkey.text!]
            let jsonDataAcc = try JSONSerialization.data(withJSONObject:dic, options: .prettyPrinted)
            accounStr = try decoder.decode(AccountXML.self, from: jsonDataAcc)
            
        }
        catch{
        }
        let valtooshow = """
        \(String(describing: accounStr!.soapStr!))
        <ns:CardNumber>\(cardNumber.text ?? "")</ns:CardNumber>
        <ns:CardExpiryDate>\(cardExpdate.text ?? "")</ns:CardExpiryDate>
        """
        let qucard = CardSoapMessage(soapvalue: valtooshow)
        
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



