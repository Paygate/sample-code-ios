//
//  SingleWebPayment.swift
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

class SingleWebPayment: UIViewController,XMLParserDelegate,UITextViewDelegate {
    
    var viewType : String = ""
    var decoder = JSONDecoder()
    
    @IBOutlet weak var Response_string: UIPlaceHolderTextView!
    @IBOutlet weak var req_textview: UIPlaceHolderTextView!
    @IBOutlet weak var paygateId: UITextField!
    @IBOutlet weak var encryptionkey: UITextField!
    @IBOutlet weak var cardExpdate: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    
    
    //Token Payment
    @IBOutlet weak var cardExpDate: UILabel!
    @IBOutlet weak var cardnum: UILabel!
    
    let responsePlaceHolder = "Response:"
    let requestPlaceholder = "Request :"
    var mainStr = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Response_string.delegate = self
        setMenuButton()
        setTextViewShdow(Response_string)
        setTextViewShdow(req_textview)
        if(viewType == "web"){
            self.title = "Web Payment"
            mainStr = self.setWebRequsetParms()
        }
        else  if(viewType == "card"){
            self.title = "Card Payment"
        }
        else{
            cardExpDate.text = "Token Description"
            cardnum.text = "Token"
        }
        
        
    }
    
    
    
    //MARK:------------------------Request Button Action/API call-----------------------------------
    @IBAction func DoWebViewAction(_ sender: Any) {
        
        self.req_textview.text = ""
        if(viewType == "card"){
            mainStr = self.SetCard()
        }
        else if(viewType == "token"){
            mainStr = self.setPaymentForToken()
        }
        self.req_textview.text = mainStr
        WebServiceHandler().PostRequestWithXml(parms: mainStr, Url: APIConstants.CardVault, headers: APIConstants.headers, Success: {(responseObject,ResponseString) -> () in
            DispatchQueue.main.async {
                self.req_textview.resignFirstResponder()
            }
            
            if(self.viewType == "web"){
                if(ResponseString.contains("Complete")){
                    self.ReadWebPaymnetMethod(Response: ResponseString)
                }
            }
            else if(self.viewType == "card"){
                if(ResponseString.contains("Complete")){
                    self.ReadWebPaymnetMethod(Response: ResponseString)
                }
                
            }
            else if(self.viewType == "token"){
                
            }
            DispatchQueue.main.sync {
                self.Response_string.text = "\(ResponseString)"
            }
            
        }, Failure: {(error) -> () in
            print(error!.description)
        },showLoader: true, hideLoader: true)
        
    }
    //MARK:------------------------Set Card For "Token Payment" ----------------------------------
    func setPaymentForToken() -> String{
        do
        {
            let paygateAccount = ["paygateId":paygateId.text,"password":encryptionkey.text]
            let jsonDataAcc = try JSONSerialization.data(withJSONObject:paygateAccount, options: .prettyPrinted)
            let accountXML = try decoder.decode(AccountXML.self, from: jsonDataAcc)
            
            let TokenAcco = ["tokenId":cardNumber.text,"tokndes":cardExpdate.text]
            let jsonDataAcc2 = try JSONSerialization.data(withJSONObject:TokenAcco, options: .prettyPrinted)
            let tokenXML = try decoder.decode(TokenXML.self, from: jsonDataAcc2)
            
            //CustomerDetailXMLModel   XML String
            let CustomerDic:[String : Any] = ["Title":"Mr","FirstName":"PayGate","LastName":"Test","Email":"itsupport@paygate.co.za","Country":"ZAF","account":paygateAccount]
            let jsonData = try JSONSerialization.data(withJSONObject: CustomerDic, options: .prettyPrinted)
            let customerStr = try decoder.decode(CustomerDetailXMLModel.self, from: jsonData)
            
            //Generate Reference
            let date = Date()
            let formatterReference = DateFormatter()
            formatterReference.dateFormat = "YmdHis"
            let orderReference = "pgtest_ios_" + formatterReference.string(from: date)
            
            let orderData = try JSONSerialization.data(withJSONObject: ["MerchantOrderId":orderReference,"Currency":"ZAR","Amount":"100"], options: .prettyPrinted)
            let orderDetail = try decoder.decode(OrderTokenItemDetails.self, from: orderData)
            
            let ConcateStr = (accountXML.soapStr)! + (customerStr.soapStr)! + (tokenXML.soapStr)! + orderDetail.soapStr
            let makeObject = TokenpaymentRequest(soapvalue:ConcateStr)
            print(makeObject.soapvalue)
            return makeObject.soapvalue
            
            
        }
        catch{
            
        }
        return ""
    }
    //MARK:------------------------Set Card For "Card Payment" ----------------------------------
    func SetCard() -> String{
        do
        {
            //Account XML
            let paygateAccount = ["paygateId":paygateId.text,"password":encryptionkey.text]
            let jsonDataAcc = try JSONSerialization.data(withJSONObject:paygateAccount, options: .prettyPrinted)
            let accountXML = try decoder.decode(AccountXML.self, from: jsonDataAcc)
            
            let cardDetails = """
            <ns:CardNumber>\(cardNumber.text!)</ns:CardNumber>
            <ns:CardExpiryDate>\(cardExpdate.text ?? "202019")</ns:CardExpiryDate>
            <ns:CVV>124</ns:CVV>
            <ns:BudgetPeriod>0</ns:BudgetPeriod>
            """
            //Redirect XMl
            let redirect = RedirectDetails(JSON:["NotifyUrl":"http://192.168.0.12/A/PayHost/notify.php","ReturnUrl":"http://192.168.0.12/A/PayHost/result.php"]) //Change this to your server url
            
            //CustomerDetailXMLModel   XML String
            let CustomerDic:[String : Any] = ["Title":"Mr","FirstName":"PayGate","LastName":"Test","Email":"itsupport@paygate.co.za","Country":"ZAF","account":paygateAccount]
            let jsonData = try JSONSerialization.data(withJSONObject: CustomerDic, options: .prettyPrinted)
            let customerStr = try decoder.decode(CustomerDetailXMLModel.self, from: jsonData)
            
            //Generate Reference
            let date = Date()
            let formatterReference = DateFormatter()
            formatterReference.dateFormat = "YmdHis"
            let orderReference = "pgtest_ios_" + formatterReference.string(from: date)
            
            //Generate TransactionDate
            let formatterTransactionDateYear = DateFormatter()
            formatterTransactionDateYear.dateFormat = "yyyy-MM-dd"
            let formatterTransactionDateTime = DateFormatter()
            formatterTransactionDateTime.dateFormat = "HH:mm:ss"
            let TransactionDate = formatterTransactionDateYear.string(from: date) + "T" + formatterTransactionDateTime.string(from: date)
            
            //Merchant Detail
            let productDIc = ["ProductCode":"ABC123","Currency":"ZAR","ProductDescription":"Misc Product","ProductCategory":"misc","ProductRisk":"XX","OrderQuantity":"1","UnitPrice":"120"]
            let orderData = try JSONSerialization.data(withJSONObject: ["MerchantOrderId":orderReference,"Currency":"ZAR","Amount":"100","TransactionDate":TransactionDate,"orderitem":productDIc], options: .prettyPrinted)
            let orderDetail = try decoder.decode(OrderItemDetails.self, from: orderData)
            
            
            let ConcateStr = (accountXML.soapStr)! + (customerStr.soapStr)! + cardDetails + (redirect?.soapStr)! + (orderDetail.soapStr)!
            
            let makeObject = CardpaymentRequest(soapvalue:ConcateStr)
            print(makeObject.soapvalue)
            return makeObject.soapvalue
            
        }
        catch{
            return ""
        }
    }
    //MARK:------------------------Set Card For "Web Payment" ----------------------------------
    func setWebRequsetParms() -> String{
        
        do
        {
            //Account XMl String
            let paygateAccount = ["paygateId":paygateId.text,"password":encryptionkey.text]
            let jsonDataAcc = try JSONSerialization.data(withJSONObject:paygateAccount, options: .prettyPrinted)
            let accountXML = try decoder.decode(AccountXML.self, from: jsonDataAcc)
            
            //Redirect XMl
            let redirect = RedirectDetails(JSON:["NotifyUrl":"http://192.168.0.12/A/PayHost/notify.php","ReturnUrl":"http://192.168.0.12/A/PayHost/result.php"])
            
            //CustomerDetailXMLModel  XML String
            let CustomerDic:[String : Any] = ["Title":"Mr","FirstName":"PayGate","LastName":"Test","Email":"itsupport@paygate.co.za","Country":"ZAF","account":paygateAccount]
            let jsonData = try JSONSerialization.data(withJSONObject: CustomerDic, options: .prettyPrinted)
            let customerStr = try decoder.decode(CustomerDetailXMLModel.self, from: jsonData)
            
            //Generate Reference
            let date = Date()
            let formatterReference = DateFormatter()
            formatterReference.dateFormat = "YmdHis"
            let orderReference = "pgtest_ios_" + formatterReference.string(from: date)
            
            //Merchant Detail
            let orderData = try JSONSerialization.data(withJSONObject: ["MerchantOrderId":orderReference,"Currency":"ZAR","Amount":"100","TransactionDate":"2018-06-30T05:51:35","billing":CustomerDic], options: .prettyPrinted)
            let orderDetail = try decoder.decode(OrderDetails.self, from: orderData)
            
            
            let ConcateStr = (accountXML.soapStr)! + (customerStr.soapStr)! + (redirect?.soapStr)! + (orderDetail.soapStr)!
            
            let makeObject = WebpaymentRequest(soapvalue:ConcateStr)
            print(makeObject.soapvalue)
            
            return makeObject.soapvalue
        }
        catch{
            return ""
            
        }
        
    }
    //MARK:------------------------ Read XMl Data------------------------
    func ReadWebPaymnetMethod(Response:String){
        var paygateid = String()
        var pay_requ_id = String()
        var ReferenceId  = String()
        var cheakSumid  = String()
        
        DispatchQueue.main.sync {
            
            do{
                var xmlDictionary = try? XMLReader.dictionary(forXMLString: Response)
                
                let dic1 : NSDictionary = xmlDictionary!["SOAP-ENV:Envelope"] as! NSDictionary
                let dic2 : NSDictionary = dic1["SOAP-ENV:Body"] as! NSDictionary
                let dic3 : NSDictionary = dic2["ns2:SinglePaymentResponse"] as! NSDictionary
                var dic4  = NSDictionary()
                if(viewType == "web"){
                    dic4 = dic3["ns2:WebPaymentResponse"] as! NSDictionary
                    let dic5  = dic4["ns2:Redirect"] as! NSDictionary
                    
                    if(dic5["ns2:RedirectUrl"] != nil){
                        let dic6 = dic5["ns2:RedirectUrl"] as! NSDictionary
                        let redirectUrl = dic6["text"] as! String
                        let urlParms = dic5["ns2:UrlParams"] as! NSArray
                        
                        let dic1 = urlParms[0] as! NSDictionary
                        let dicvalue = dic1["ns2:value"] as! NSDictionary
                        paygateid = dicvalue["text"] as! String
                        
                        let dic2 = urlParms[1] as! NSDictionary
                        let payreqVal = dic2["ns2:value"] as! NSDictionary
                        pay_requ_id = payreqVal["text"] as! String
                        
                        let dic3 = urlParms[2] as! NSDictionary
                        let ReferenceDic = dic3["ns2:value"] as! NSDictionary
                        ReferenceId = ReferenceDic["text"] as! String
                        
                        let dic4 = urlParms[3] as! NSDictionary
                        let cheakSum = dic4["ns2:value"] as! NSDictionary
                        cheakSumid = cheakSum["text"] as! String
                        
                        var PassToDic = [String:String]()
                        PassToDic["url"] = redirectUrl
                        PassToDic["ref_id"] = ReferenceId
                        PassToDic["chaeksum_id"] = cheakSumid
                        PassToDic["payGate_id"] = paygateid
                        PassToDic["pay_requ_id"] = pay_requ_id
                        
                        let mainStoryBoard = UIStoryboard(name: StoryboardID.CardPayment, bundle: nil)
                        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                        vc.PassToDic = PassToDic
                        self.navigationController?.pushViewController(vc, animated:true)
                    }
                    
                }
                else  if(viewType == "card"){
                    dic4 = dic3["ns2:CardPaymentResponse"] as! NSDictionary
                    
                    let dic5  = dic4["ns2:Redirect"] as! NSDictionary
                    
                    if(dic5["ns2:RedirectUrl"] != nil){
                        let dic6 = dic5["ns2:RedirectUrl"] as! NSDictionary
                        let redirectUrl = dic6["text"] as! String
                        let urlParms = dic5["ns2:UrlParams"] as! NSArray
                        
                        
                        
                        let dic2 = urlParms[0] as! NSDictionary
                        let payreqVal = dic2["ns2:value"] as! NSDictionary
                        pay_requ_id = payreqVal["text"] as! String
                        
                        let dic3 = urlParms[1] as! NSDictionary
                        let ReferenceDic = dic3["ns2:value"] as! NSDictionary
                        paygateid = ReferenceDic["text"] as! String
                        
                        let dic4 = urlParms[2] as! NSDictionary
                        let cheakSum = dic4["ns2:value"] as! NSDictionary
                        
                        cheakSumid = cheakSum["text"] as! String
                        
                        
                        var PassToDic = [String:String]()
                        PassToDic["url"] = redirectUrl
                        PassToDic["ref_id"] = ReferenceId
                        PassToDic["chaeksum_id"] = cheakSumid
                        PassToDic["payGate_id"] = paygateid
                        PassToDic["pay_requ_id"] = pay_requ_id
                        
                        let mainStoryBoard = UIStoryboard(name: StoryboardID.CardPayment, bundle: nil)
                        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                        vc.PassToDic = PassToDic
                        self.navigationController?.pushViewController(vc, animated:true)
                        
                    }
                }
                
                
            }
            catch{
                
            }
        }
        
    }
}
