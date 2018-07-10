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
let SCREENWIDTH = UIScreen.main.bounds.size.width
let SCREENHEIGHT = UIScreen.main.bounds.size.height

struct Constants {
    static let My_userDefault = UserDefaults.standard
    static let My_Notification = NotificationCenter.default
    
    // Notification names
    static let notificationHotelSearchCompleted = Notification.Name("hotelSearchCompleted")
}

struct IdentifireCell {
    static let MENUCELL = "menucell"
    
    static let My_userDefault = UserDefaults.standard
    static let My_Notification = NotificationCenter.default
    
    // Notification names
    static let notificationHotelSearchCompleted = Notification.Name("hotelSearchCompleted")
}

//ColorConstants
struct AppColor {
    static let appPrimaryColor = #colorLiteral(red: 0, green: 0.4745098039, blue: 0.4196078431, alpha: 1)
    static let NavigattionTitleColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let placeholderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let naviagtionBarTintColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
    static let navigationtintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let greenColor =  #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    static let blueColor =  #colorLiteral(red: 0.2396743299, green: 0.09778001986, blue: 0.529760741, alpha: 1)
}
