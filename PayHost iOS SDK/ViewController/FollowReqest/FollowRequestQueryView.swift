//
//  FollowRequestQueryView.swift
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
class FollowRequestQueryView: UIViewController {
    
    @IBOutlet weak var vaultIdConstant: NSLayoutConstraint!
    
    @IBOutlet weak var transactionTypeHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var transactionTypeView: UIView!
    @IBOutlet weak var tansactiontype: UITextField!
    @IBOutlet weak var vaultIdlabelText: UILabel!
    @IBOutlet weak var Response: UITextView!
    @IBOutlet weak var request: UITextView!
    @IBOutlet weak var paygateId: UITextField!
    @IBOutlet weak var encryptionkey: UITextField!
    @IBOutlet weak var valutId: UITextField!
    var accounStr:AccountXML?
    @IBOutlet weak var amounttext: UITextField!
    @IBOutlet weak var valutIDView: UIView!
    var viewType = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetUpView()
    }
    //MARK: --------------SetUp VIew------------------------
    func SetUpView(){
        vaultIdConstant.constant = 0
        transactionTypeHeightConstant.constant = 0
        setTextViewShdow(request)
        setTextViewShdow(Response)
        valutIDView.subviews.forEach { $0.isHidden = true }
        transactionTypeView.subviews.forEach { $0.isHidden = true }
        if(viewType == "query"){
            self.title = "Query"
        }
            
        else if(viewType == "void"){
            self.title = "Void"
            transactionTypeHeightConstant.constant = 50
            transactionTypeView.subviews.forEach { $0.isHidden = false }
            vaultIdlabelText.text = "Transaction Id"
        }
        else if(viewType == "refund"){
            self.title = "Refund"
            vaultIdlabelText.text = "Transaction Id"
            vaultIdConstant.constant = 50
            valutIDView.subviews.forEach { $0.isHidden = false }
        }
        else {
            self.title = "Settlement"
        }
        self.setMenuButton()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: --------------------------------------Call API-------------------------------------
    @IBAction func docardValueAction(_ sender: Any) {
        CallAPI()
    }
    func CallAPI(){
        do{
            let decoder = JSONDecoder()
            let dic = ["paygateId":paygateId.text!,"password":encryptionkey.text!]
            let jsonDataAcc = try JSONSerialization.data(withJSONObject:dic, options: .prettyPrinted)
            accounStr = try decoder.decode(AccountXML.self, from: jsonDataAcc)
            print(accounStr?.soapStr ?? "error")
        }
        catch{
        }
        var valtooshow = String()
        var SoapStr = String()
        
        if(viewType == "query"){
            valtooshow = """
            \(accounStr!.soapStr!)
            <ns:PayRequestId>\(valutId.text ?? "")</ns:PayRequestId>
            """
            let qucard = QueryCardRequest(soapvalue: valtooshow)
            SoapStr = qucard.soapvalue
        }
        else if(viewType == "void"){
            valtooshow = """
            \(accounStr!.soapStr!)
            <ns:TransactionId>\(valutId.text ?? "")</ns:TransactionId>
            <ns:TransactionType>\(tansactiontype.text ?? "")</ns:TransactionType>
            """
            let qucard = VoidQueryRequest(soapvalue: valtooshow)
            SoapStr = qucard.soapvalue
        }
        else if(viewType == "settle"){
            valtooshow = """
            \(accounStr!.soapStr!)
            <ns:TransactionId>\(valutId.text ?? "")</ns:TransactionId>
            """
            let qucard = SettlementQueryRequest(soapvalue: valtooshow)
            SoapStr = qucard.soapvalue
            
        }
        else if(viewType == "refund"){
            valtooshow = """
            \(accounStr!.soapStr!)
            <ns:TransactionId>\(valutId.text ?? "")</ns:TransactionId>
            <ns:Amount>\(amounttext.text ?? "")</ns:Amount>
            """
            let qucard = RefundQueryRequest(soapvalue: valtooshow)
            SoapStr = qucard.soapvalue
            
        }
        print(SoapStr)
        request.text = SoapStr
        WebServiceHandler().PostRequestWithXml(parms: SoapStr, Url: APIConstants.CardVault, headers: APIConstants.headers, Success: {(responseObject,ResponseString) -> () in
            
            DispatchQueue.main.sync {
                self.Response.text = ResponseString
            }
            if(ResponseString.contains("Completed")){
            }
        }, Failure: {(error) -> () in
            print(error!.description)
        },showLoader: true, hideLoader: true)
    }
    
}
