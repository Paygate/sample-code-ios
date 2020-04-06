//
//  WebViewController.swift
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
import KRProgressHUD
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate,WKUIDelegate, UIScrollViewDelegate {
    @IBOutlet weak var webView: WKWebView!
    var PassToDic = [String:String]()
    var webStr = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.configuration.userContentController.addUserScript(self.getZoomDisableScript())
        self.setWebView()
    }
    //Disable zoom webview
    private func getZoomDisableScript() -> WKUserScript {
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum- scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);"
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    }
    
    //MARK:----------------------------Set WebView With parms ------------------------
    func setWebView(){
        
        
        var request = URLRequest(url: URL(string: PassToDic["url"]!)!)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let body = "PAYGATE_ID=\(PassToDic["payGate_id"]!)&REFERENCE=\(PassToDic["ref_id"]!)&CHECKSUM=\(PassToDic["chaeksum_id"]!)&PAY_REQUEST_ID=\(PassToDic["pay_requ_id"]!)"
        request.httpBody = body.data(using: .utf8)
 
        let task = URLSession.shared.dataTask(with: request) { (data : Data?, response : URLResponse?, error : Error?) in
            if data != nil
            {
                
                if String(data: data!, encoding: .utf8) != nil
                {
                    _ = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    DispatchQueue.main.sync {
                        self.webView.load(request as URLRequest)
                        self.webView.allowsBackForwardNavigationGestures = false
                        
                    }
                }
            }
        }
        task.resume()
        
    }
}


