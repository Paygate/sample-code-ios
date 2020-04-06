//
//  WebServiceHandler.swift
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

import Foundation
import KRProgressHUD
class WebServiceHandler{
    
    static let instance = WebServiceHandler()
    func PostRequestWithXml(parms:String,Url:String,headers:[String:String],Success:@escaping (_ responseObject:AnyObject?,_ ResponseString:String) -> (),Failure: @escaping (_ error:NSError?) -> (),showLoader isShowDefaultLoader:Bool, hideLoader isHideDefaultLoader:Bool){
        KRProgressHUD.show()
        let postData: Data? = parms.data(using: String.Encoding.utf8, allowLossyConversion: true)
        
        let request = NSMutableURLRequest(url: NSURL(string: self.getFullUrl(str: Url))! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        request.setValue(postData?.count.description, forHTTPHeaderField: "Content-Length")
        print("URL = \(self.getFullUrl(str: Url))")
        request.httpBody = postData
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            KRProgressHUD.dismiss()
            if (error != nil) {
                Failure(error! as NSError)
                print(error ?? "Error fetching data")
            } else {
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                Success(response,strData! as String)
                print("Body: \(strData ?? "")")
            }
        })
        dataTask.resume()
    }
    func getFullUrl(str:String) -> String{
        return APIConstants.BaseServerUrl + str
    }
    
}
