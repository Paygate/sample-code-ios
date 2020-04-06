//
//  APIHelper.swift
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
import ObjectMapper
protocol Getvalue {
    var soapvalue: String { get }
}

class CardSoapMessage: Getvalue {
    var soapMessage = String()
    let soapvalue: String
    init(soapvalue: String) {
        
        soapMessage =  """
        <SOAP-ENV:\(SoapActionID.XMLENVLine)">
        <SOAP-ENV:Body>
        <ns:\(SoapActionID.SINVR)>
        <ns:\(SoapActionID.CARVR)>
        \(soapvalue)
        </ns:\(SoapActionID.CARVR)>
        </ns:\(SoapActionID.SINVR)>
        </SOAP-ENV:Body>
        </SOAP-ENV:Envelope>
        """
        self.soapvalue = soapMessage
        
    }
}
class WebpaymentRequest: Getvalue {
    var soapMessage = String()
    let soapvalue: String
    init(soapvalue: String) {
        
        soapMessage =  """
        <SOAP-ENV:\(SoapActionID.XMLENVLine)">
        <SOAP-ENV:Body>
        <ns:\(SoapActionID.SIPAYR)>
        <ns:\(SoapActionID.WEBPAYRE)>
        \(soapvalue)
        </ns:\(SoapActionID.WEBPAYRE)>
        </ns:\(SoapActionID.SIPAYR)>
        </SOAP-ENV:Body>
        </SOAP-ENV:Envelope>
        """
        self.soapvalue = soapMessage
        
    }
}
class CardpaymentRequest: Getvalue {
    var soapMessage = String()
    let soapvalue: String
    init(soapvalue: String) {
        
        soapMessage =  """
        <SOAP-ENV:\(SoapActionID.XMLENVLine)">
        <SOAP-ENV:Body>
        <ns:\(SoapActionID.SIPAYR)>
        <ns:\(SoapActionID.CARDPAYRE)>
        \(soapvalue)
        </ns:\(SoapActionID.CARDPAYRE)>
        </ns:\(SoapActionID.SIPAYR)>
        </SOAP-ENV:Body>
        </SOAP-ENV:Envelope>
        """
        self.soapvalue = soapMessage
        
    }
}
class TokenpaymentRequest: Getvalue {
    var soapMessage = String()
    let soapvalue: String
    init(soapvalue: String) {
        
        soapMessage =  """
        <SOAP-ENV:\(SoapActionID.XMLENVLine)">
        <SOAP-ENV:Body>
        <ns:\(SoapActionID.SIPAYR)>
        <ns:\(SoapActionID.TOKENPAYRE)>
        \(soapvalue)
        </ns:\(SoapActionID.TOKENPAYRE)>
        </ns:\(SoapActionID.SIPAYR)>
        </SOAP-ENV:Body>
        </SOAP-ENV:Envelope>
        """
        self.soapvalue = soapMessage
        
    }
}
class DeleteCardMessage: Getvalue {
    var soapMessage = String()
    let soapvalue: String
    init(soapvalue: String) {
        
        soapMessage =  """
        <SOAP-ENV:\(SoapActionID.XMLENVLine)">
        <SOAP-ENV:Body>
        <ns:\(SoapActionID.SINVR)>
        <ns:\(SoapActionID.DEVR)>
        \(soapvalue)
        </ns:\(SoapActionID.DEVR)>
        </ns:\(SoapActionID.SINVR)>
        </SOAP-ENV:Body>
        </SOAP-ENV:Envelope>
        """
        self.soapvalue = soapMessage
        
    }
}
class LookupCardMessage: Getvalue {
    var soapMessage = String()
    let soapvalue: String
    init(soapvalue: String) {
        
        soapMessage =  """
        <SOAP-ENV:\(SoapActionID.XMLENVLine)">
        <SOAP-ENV:Body>
        <ns:\(SoapActionID.SINVR)>
        <ns:\(SoapActionID.LOOUVR)>
        \(soapvalue)
        </ns:\(SoapActionID.LOOUVR)>
        </ns:\(SoapActionID.SINVR)>
        </SOAP-ENV:Body>
        </SOAP-ENV:Envelope>
        """
        self.soapvalue = soapMessage
        
    }
}
class QueryCardRequest: Getvalue {
    var soapMessage = String()
    let soapvalue: String
    init(soapvalue: String) {
        print(soapvalue)
        soapMessage =  """
        <SOAP-ENV:\(SoapActionID.XMLENVLine)">
        <SOAP-ENV:Body>
        <ns:\(SoapActionID.SIFOR)>
        <ns:\(SoapActionID.QUERE)>
        \(soapvalue)
        </ns:\(SoapActionID.QUERE)>
        </ns:\(SoapActionID.SIFOR)>
        </SOAP-ENV:Body>
        </SOAP-ENV:Envelope>
        """
        self.soapvalue = soapMessage
        
    }
}
class VoidQueryRequest: Getvalue {
    var soapMessage = String()
    let soapvalue: String
    init(soapvalue: String) {
        print(soapvalue)
        soapMessage =  """
        <SOAP-ENV:\(SoapActionID.XMLENVLine)">
        <SOAP-ENV:Body>
        <ns:\(SoapActionID.SIFOR)>
        <ns:\(SoapActionID.VOiDR)>
        \(soapvalue)
        </ns:\(SoapActionID.VOiDR)>
        </ns:\(SoapActionID.SIFOR)>
        </SOAP-ENV:Body>
        </SOAP-ENV:Envelope>
        """
        self.soapvalue = soapMessage
        
    }
}
class SettlementQueryRequest: Getvalue {
    var soapMessage = String()
    let soapvalue: String
    init(soapvalue: String) {
        print(soapvalue)
        soapMessage =  """
        <SOAP-ENV:\(SoapActionID.XMLENVLine)">
        <SOAP-ENV:Body>
        <ns:\(SoapActionID.SIFOR)>
        <ns:\(SoapActionID.SETTLEREQ)>
        \(soapvalue)
        </ns:\(SoapActionID.SETTLEREQ)>
        </ns:\(SoapActionID.SIFOR)>
        </SOAP-ENV:Body>
        </SOAP-ENV:Envelope>
        """
        self.soapvalue = soapMessage
        
    }
}
class RefundQueryRequest: Getvalue {
    var soapMessage = String()
    let soapvalue: String
    init(soapvalue: String) {
        print(soapvalue)
        soapMessage =  """
        <SOAP-ENV:\(SoapActionID.XMLENVLine)">
        <SOAP-ENV:Body>
        <ns:\(SoapActionID.SIFOR)>
        <ns:\(SoapActionID.REFUNDEST)>
        \(soapvalue)
        </ns:\(SoapActionID.REFUNDEST)>
        </ns:\(SoapActionID.SIFOR)>
        </SOAP-ENV:Body>
        </SOAP-ENV:Envelope>
        """
        self.soapvalue = soapMessage
        
    }
}

protocol  Accountvalue{
    var paygateId: String { get }
    var password: String { get }
}

struct CustomerDetailXML: Mappable {
    
    var Title: String!
    var FirstName: String!
    var LastName: String!
    var Email: String!
    var Country: String!
    
    var soapStr: String!
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        Title       <- map["Title"]
        FirstName        <- map["FirstName"]
        LastName       <- map["LastName"]
        Email        <- map["Email"]
        Country       <- map["Country"]
        
        soapStr = """
        <ns:Customer>
        <ns:Title>\(Title!)</ns:Title>
        <ns:FirstName>\(FirstName!)</ns:FirstName>
        <ns:LastName>\(LastName!)</ns:LastName>
        <ns:Email>\(Email!)</ns:Email>
        <ns:Address>
        <ns:Country>\(Country!)</ns:Country>
        </ns:Address>
        </ns:Customer>
        """
        
        print(soapStr as Any)
    }
}

struct AccountXML: Codable {
    
    var paygateId: String!
    var password: String!
    var soapStr: String!
    
    enum CodingKeys: String, CodingKey {
        case paygateId = "paygateId"
        case password = "password"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        paygateId = try values.decodeIfPresent(String.self, forKey: .paygateId)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        
        soapStr = """
        <ns:Account>
        <ns:PayGateId>\(paygateId!)</ns:PayGateId>
        <ns:Password>\(password!)</ns:Password>
        </ns:Account>
        """
    }
}
struct TokenXML: Codable {
    
    var tokenId: String!
    var tokndes: String!
    var soapStr: String!
    
    enum CodingKeys: String, CodingKey {
        case tokenId = "tokenId"
        case tokndes = "tokndes"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tokenId = try values.decodeIfPresent(String.self, forKey: .tokenId)
        tokndes = try values.decodeIfPresent(String.self, forKey: .tokndes)
        
        soapStr = """
        <ns:Token>\(tokenId!)</ns:Token>
        <ns:TokenDetail>\(tokndes!)</ns:TokenDetail>
        """
    }
}
struct CustomerDetailXMLModel: Codable {
    
    var Title: String!
    var FirstName: String!
    var LastName: String!
    var Email: String!
    var Country: String!
    var account:AccountXML!
    var soapStr: String!
    
    
    enum CodingKeys: String, CodingKey {
        case Title = "Title"
        case FirstName = "FirstName"
        case LastName = "LastName"
        case Email = "Email"
        case Country = "Country"
        case account = "account"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Title = try values.decodeIfPresent(String.self, forKey: .Title)
        FirstName = try values.decodeIfPresent(String.self, forKey: .FirstName)
        LastName = try values.decodeIfPresent(String.self, forKey: .LastName)
        Email = try values.decodeIfPresent(String.self, forKey: .Email)
        Country = try values.decodeIfPresent(String.self, forKey: .Country)
        account = try values.decodeIfPresent(AccountXML.self, forKey: .account)
        
        soapStr = """
        <ns:Customer>
        <ns:Title>\(Title!)</ns:Title>
        <ns:FirstName>\(FirstName!)</ns:FirstName>
        <ns:LastName>\(LastName!)</ns:LastName>
        <ns:Email>\(Email!)</ns:Email>
        <ns:Address>
        <ns:Country>\(Country!)</ns:Country>
        </ns:Address>
        </ns:Customer>
        """
    }
    
}

struct RedirectDetails: Mappable {
    
    var NotifyUrl: String!
    var ReturnUrl: String!
    var soapStr: String!
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        NotifyUrl       <- map["NotifyUrl"]
        ReturnUrl        <- map["ReturnUrl"]
        
        soapStr = """
        <ns:Redirect>
        <ns:NotifyUrl>\(NotifyUrl!)</ns:NotifyUrl>
        <ns:ReturnUrl>\(ReturnUrl!)</ns:ReturnUrl>
        </ns:Redirect>
        """
    }
}

struct OrderDetails : Codable{
    var MerchantOrderId: String!
    var Currency: String!
    var Amount: String!
    var TransactionDate: String!
    var billing: CustomerDetailXMLModel!
    
    var soapStr: String!
    
    enum CodingKeys: String, CodingKey {
        
        case billing = "billing"
        case MerchantOrderId = "MerchantOrderId"
        case Currency = "Currency"
        case Amount = "Amount"
        case TransactionDate = "TransactionDate"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        MerchantOrderId = try values.decodeIfPresent(String.self, forKey: .MerchantOrderId)
        Currency = try values.decodeIfPresent(String.self, forKey: .Currency)
        Amount = try values.decodeIfPresent(String.self, forKey: .Amount)
        TransactionDate = try values.decodeIfPresent(String.self, forKey: .TransactionDate)
        billing = try values.decodeIfPresent(CustomerDetailXMLModel.self, forKey: .billing)
        
        soapStr = """
        <ns:Order>
        <ns:MerchantOrderId>\(MerchantOrderId!)</ns:MerchantOrderId>
        <ns:Currency>\(Currency!)</ns:Currency>
        <ns:Amount>\(Amount!)</ns:Amount>
        <ns:TransactionDate>\(TransactionDate!)</ns:TransactionDate>
        <ns:BillingDetails>\(billing!.soapStr!)
        <ns:Address>
        <ns:Country>ZAF</ns:Country>
        </ns:Address>
        </ns:BillingDetails>
        <ns:Locale>en-us</ns:Locale>
        </ns:Order>
        """
    }
    
}
struct OrderItemDetails : Codable{
    
    var MerchantOrderId: String!
    var Currency: String!
    var Amount: String!
    var TransactionDate: String!
    var orderitem: ProductDetails!
    
    var soapStr: String!
    
    enum CodingKeys: String, CodingKey {
        
        case MerchantOrderId = "MerchantOrderId"
        case Currency = "Currency"
        case Amount = "Amount"
        case TransactionDate = "TransactionDate"
        case orderitem = "orderitem"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        MerchantOrderId = try values.decodeIfPresent(String.self, forKey: .MerchantOrderId)
        Currency = try values.decodeIfPresent(String.self, forKey: .Currency)
        Amount = try values.decodeIfPresent(String.self, forKey: .Amount)
        TransactionDate = try values.decodeIfPresent(String.self, forKey: .TransactionDate)
        orderitem = try values.decodeIfPresent(ProductDetails.self, forKey: .orderitem)
        
        soapStr = """
        <ns:Order>
        <ns:MerchantOrderId>\(MerchantOrderId!)</ns:MerchantOrderId>
        <ns:Currency>\(Currency!)</ns:Currency>
        <ns:Amount>\(Amount!)</ns:Amount>
        <ns:TransactionDate>\(TransactionDate ?? "")</ns:TransactionDate>
        \(orderitem!.soapStr!)
        </ns:Order>
        """
    }
}
struct OrderTokenItemDetails : Codable{
    
    var MerchantOrderId: String!
    var Currency: String!
    var Amount: String!
    var soapStr: String!
    
    enum CodingKeys: String, CodingKey {
        
        case MerchantOrderId = "MerchantOrderId"
        case Currency = "Currency"
        case Amount = "Amount"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        MerchantOrderId = try values.decodeIfPresent(String.self, forKey: .MerchantOrderId)
        Currency = try values.decodeIfPresent(String.self, forKey: .Currency)
        Amount = try values.decodeIfPresent(String.self, forKey: .Amount)
        
        soapStr = """
        <ns:Order>
        <ns:MerchantOrderId>\(MerchantOrderId!)</ns:MerchantOrderId>
        <ns:Currency>\(Currency!)</ns:Currency>
        <ns:Amount>\(Amount!)</ns:Amount>
        </ns:Order>
        """
        
    }
    
}

struct ProductDetails : Codable{
    
    var ProductCode:String?
    var ProductDescription:String?
    var ProductCategory:String?
    var ProductRisk:String?
    var OrderQuantity:String?
    var UnitPrice:String?
    var Currency:String?
    var soapStr: String?
    
    enum CodingKeys: String, CodingKey {
        
        case ProductCode = "ProductCode"
        case ProductDescription = "ProductDescription"
        case ProductCategory = "ProductCategory"
        case ProductRisk = "ProductRisk"
        case OrderQuantity = "OrderQuantity"
        case UnitPrice = "UnitPrice"
        case Currency = "Currency"
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ProductCode = try values.decodeIfPresent(String.self, forKey: .ProductCode)
        ProductDescription = try values.decodeIfPresent(String.self, forKey: .ProductDescription)
        ProductCategory = try values.decodeIfPresent(String.self, forKey: .ProductCategory)
        ProductRisk = try values.decodeIfPresent(String.self, forKey: .ProductRisk)
        OrderQuantity = try values.decodeIfPresent(String.self, forKey: .OrderQuantity)
        UnitPrice = try values.decodeIfPresent(String.self, forKey: .UnitPrice)
        Currency = try values.decodeIfPresent(String.self, forKey: .Currency)
        
        soapStr = """
        <ns:OrderItems>
        <ns:ProductCode>\(ProductCode!)</ns:ProductCode>
        <ns:ProductDescription>\(ProductDescription!)</ns:ProductDescription>
        <ns:ProductCategory>\(ProductCategory!)</ns:ProductCategory>
        <ns:ProductRisk>\(ProductRisk!)</ns:ProductRisk>
        <ns:OrderQuantity>\(OrderQuantity!)</ns:OrderQuantity>
        <ns:UnitPrice>\(UnitPrice!)</ns:UnitPrice>
        <ns:Currency>\(Currency!)</ns:Currency>
        </ns:OrderItems>
        """
    }
}
