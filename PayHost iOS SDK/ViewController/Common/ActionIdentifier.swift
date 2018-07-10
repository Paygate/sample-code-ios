//
//  ActionIdentifier.swift
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

import Foundation
import UIKit
class StoryboardNames {
    static let loginScreen = "LoginScreen"
    
}
class StoryboardID {
    static let CardPayment = "CardPayment"
    static let Main = "Main"
    
}
class SoapActionID {
    static let XMLENVLine = """
            Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.paygate.co.za/PayHOST
            """
    static let SINVR = "SingleVaultRequest"
    static let CARVR = "CardVaultRequest"
    static let DEVR = "DeleteVaultRequest"
    static let LOOUVR = "LookUpVaultRequest"
    
    static let SIFOR = "SingleFollowUpRequest"
    static let QUERE = "QueryRequest"
    static let VOiDR = "VoidRequest"
    static let SETTLEREQ = "SettlementRequest"
    
    static let SIPAYR = "SinglePaymentRequest"
    static let WEBPAYRE = "WebPaymentRequest"
    static let CARDPAYRE = "CardPaymentRequest"
    static let REFUNDEST = "RefundRequest"
    static let TOKENPAYRE = "TokenPaymentRequest"
    
}

