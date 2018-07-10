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
class WebViewController: UIViewController {
    
    @IBOutlet weak var webview: UIWebView!
    var PassToDic = [String:String]()
    var webStr = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setWebView()
        
        // Do any additional setup after loading the view.
    }
    //MARK:----------------------------Set WebView With parms ------------------------
    func setWebView(){
        
        
        var request = URLRequest(url: URL(string: PassToDic["url"]!)!)
        request.httpMethod = "POST"
        let body = "PAYGATE_ID=\(PassToDic["payGate_id"]!)&REFERENCE=\(PassToDic["ref_id"]!)&CHECKSUM=\(PassToDic["chaeksum_id"]!)&PAY_REQUEST_ID=\(PassToDic["pay_requ_id"]!)"
        request.httpBody = body.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data : Data?, response : URLResponse?, error : Error?) in
            if data != nil
            {
                
                if String(data: data!, encoding: .utf8) != nil
                {
                    let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    DispatchQueue.main.sync {
                        self.webview.loadRequest(request as URLRequest)
                    }
                }
            }
        }
        task.resume()
        
    }
    
    
}

extension WebViewController:UIWebViewDelegate{
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error)
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        KRProgressHUD.show()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let resp: CachedURLResponse? = URLCache.shared.cachedResponse(for: webview.request!)
        if let aFields = (resp?.response as? HTTPURLResponse)?.allHeaderFields {
            print("\(aFields)")
        }
        KRProgressHUD.dismiss()
    }
}
