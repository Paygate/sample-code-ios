//
//  APIConstants.swift
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

struct APIConstants{
    
    static let BaseServerUrl = "https://secure.paygate.co.za/"
    
    static let CardVault = "payhost/process.trans"
    
    static let headers = [
        "Content-Type": "text/xml",
        "Cache-Control": "no-cache"
    ]
    
}
