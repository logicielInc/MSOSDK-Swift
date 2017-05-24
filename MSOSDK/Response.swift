//
//  Response.swift
//  MSOSDK
//
//  Created by John Setting on 5/22/17.
//  Copyright © 2017 Logiciel Inc. All rights reserved.
//

import Foundation

struct Webserver {

}

protocol NetserverResponse {
  var command: String? { get set }
  var status: String? { get set }
  var trailingResponse: [String]? { get set }
  init()
  init(_ response: String?) throws
}

extension String {

  func stringBetween(_ begin: String?, end: String?) -> String? {

    guard let begin = begin, let end = end else {
      return nil
    }

    let scanner = Scanner(string: self)
    var scanned: NSString?

    if scanner.scanUpTo(begin, into:nil) {
      scanner.scanString(end, into:nil)
      if scanner.scanUpTo(end, into:&scanned) {
        return scanned as String?
      }
    }

    return nil
  }

}

extension NetserverResponse {

  init(_ response: String?) throws {

    self.init()
    
    guard let response = response, response.isEmpty == false else {
      throw MSOSDKError.ping()
    }

    if response.hasPrefix("Invalid Login:") ||
      response.hasSuffix("Invalid ID/Password or Access Level.") {
      throw MSOSDKError.invalidCredentials()
    }

    if response.hasPrefix("Invalid Event:") {
      throw MSOSDKError.invalidEvent()
    }

    if response.hasPrefix("OutOfMemoryException") {
      throw MSOSDKError.outOfMemory()
    }

    if response.hasPrefix("Invalid Event.") {

      guard let eventId = response.stringBetween("[", end: "]") else {
        throw MSOSDKError.invalidEvent()
      }

      let start = response.index(eventId.startIndex, offsetBy: 2)
      let end = response.index(response.endIndex, offsetBy: 0)
      let range = start..<end
      let eventName = response.substring(with: range)
      throw MSOSDKError.eventUpdated(eventName, eventId: eventId)

    }

    let components = response.components(separatedBy: "^")

    guard let command = components[safe: 0],
      command != "iPad connection terminated" else {
        status = "OK"
        return
    }

    status = components[safe: 1]

    if components.count > 2 {

      let length = components.count - 2
      trailingResponse = Array(components.suffix(length))

    }

  }

  var trailingResponse: [String]? {
    return nil
  }

  var status: String? {
    return nil
  }

  var command: String? {
    return nil
  }

}

extension Collection where Indices.Iterator.Element == Index {

  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  subscript (safe index: Index) -> Generator.Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

struct Ping: NetserverResponse {
  var trailingResponse: [String]?

  var status: String?

  var command: String?

  public private(set) var extendedCommand: String?
  public private(set) var eventId: String?
  public private(set) var eventName: String?
}

/**
 @brief MSO will return back 3 results: Always Append, Always Retrieve, Offer Choice
 */
enum BehaviorWhenEnteringItem: UInt8 {
  case append
  case retrieve
  case choice
}

/**
 @brief MSO will return back 3 results: Item Setup, Back Order, Offer Choice
 */
enum RedAlertIfOrderQuantityGreaterThanOnHand: UInt8 {
  case itemSetup
  case backorder
  case choice
}

struct ProductCount {
  public private(set) var objectCount: UInt8
}

struct SaveCustomer {
  public private(set) var objectCount: UInt8
  public private(set) var mainstore: String?
  public private(set) var accountNumber: String?
  public private(set) var terms: String?
  public private(set) var priceLevel: UInt8
}

struct UpdateCustomer {
  public private(set) var objectCount: UInt8
  public private(set) var message: String?
}

struct SaveCustomerAddress {
  public private(set) var customerName: String?
  public private(set) var contactName: String?
  public private(set) var address1: String?
  public private(set) var address2: String?
  public private(set) var city: String?
  public private(set) var state: String?
  public private(set) var zip: String?
  public private(set) var country: String?
  public private(set) var phone: String?
  public private(set) var fax: String?
  public private(set) var email: String?
}

protocol Sync: NetserverResponse {
  var objectCount: UInt8 { get set }
  var nextIndex: String? { get set }
  var data: String? { get set }
}

struct SyncSettings {

}

struct SyncCustomers {

}

struct SaveCustomerMapping {

}

struct UpdateCustomerMapping {

}

struct SyncPurchaseHistory {

}

struct Login {
  public private(set) var response: String?
  public private(set) var userId: String?
  public private(set) var manager: Bool = false
  public private(set) var priceLevels: Bool = false
  public private(set) var allowPriceLevel1: Bool = false
  public private(set) var allowPriceLevel2: Bool = false
  public private(set) var allowPriceLevel3: Bool = false
  public private(set) var allowPriceLevel4: Bool = false
  public private(set) var allowPriceLevel5: Bool = false
  public private(set) var allowUserDefinedPriceLevel: Bool = false
}

struct QuerySalesOrder {
  public private(set) var objectCount: UInt8
  public private(set) var data: String?
  public private(set) var itemSet: String?
}

struct QueryImages {
  public private(set) var objectCount: UInt8
  public private(set) var images: [String]?
}

struct SaveImage {
  public private(set) var identifier: String?
  public private(set) var message: String?
}

struct SubmitSalesOrder {
  public private(set) var objectCount: UInt8
  public private(set) var orderNumber: String?
  public private(set) var customerName: String?
  public private(set) var customerAccountNumber: String?
}

struct Settings {

  public private(set) var companyPriceLevel: UInt8 = 1

  /// if yes, multiple companies, else, single company
  public private(set) var multiCompany: Bool = false
  public private(set) var allowCustomAssortment: Bool = false

  public private(set) var eventName: String?
  public private(set) var eventId: String?
  public private(set) var backupOrder: String
  public private(set) var keepSubmittedOrderCopy: String
  public private(set) var terms: String
  public private(set) var shipTo: String

  public private(set) var bulkSellingDescription: String

  /// MARK: Customer
  public private(set) var lastPurchasePricePriority: String

  /// MARK: S.O. Message
  public private(set) var companyPolicy: String
  public private(set) var customerGreeting: String
  public private(set) var payment: String

  public private(set) var customerAddress: CustomerAddress
  public private(set) var customizedSO: CustomizedSO
  public private(set) var configuration1: Configuration1
  public private(set) var configuration2: Configuration2
  public private(set) var pdaConfiguration1: PDAConfiguration1
  public private(set) var pdaConfiguration2: PDAConfiguration2

  struct CustomerAddress {
    public private(set) var companyName: String
    public private(set) var email: String?
    public private(set) var website: String?
    public private(set) var pin: String
    public private(set) var address1: String?
    public private(set) var address2: String?
    public private(set) var city: String?
    public private(set) var phone1: String?
    public private(set) var phone2: String?
    public private(set) var state: String?
    public private(set) var country: String?
    public private(set) var zip: String?
    public private(set) var fax: String?
  }

  struct CustomizedSO {

    /// NOTE : 17 Elements (first and last can be empty strings)
    /// NOTE : Unsent fields
    /// - Print Photo on Customer Copy
    /// - Print Photo on Merchant Copy
    /// - Print Barcode on Customer Copy
    /// - Print Barcode on Merchant Copy
    /// - Mask Credit Card Info On Merchant Copy
    /// - Suppress C/P
    /// - For Tag Along/Set Items, Show Basic Info Only
    /// - Print Total Items and Units
    /// - Print Order Log
    /// - Suppress Price when Price = 0
    /// - Show Item# & Description only when Price = 0
    public private(set) var ucp: Bool
    public private(set) var description2: Bool
    public private(set) var itemVendorName: Bool
    public private(set) var manufacturerName: Bool
    public private(set) var orderTotal: Bool
    public private(set) var sortByItemNumber: Bool
    public private(set) var msrp: Bool
    public private(set) var price: Bool
    public private(set) var itemColorSizeAbbreviation: Bool
    public private(set) var itemWeight: Bool
    public private(set) var totalWeight: Bool
    public private(set) var itemVolume: Bool
    public private(set) var totalVolume: Bool
    public private(set) var itemDiscountIfDiscounted: Bool
    public private(set) var ifBulkSellingShowQuantity: Bool
    public private(set) var ifBulkSellingShowPrice: Bool

    /// This is shown in Event -> Setup -> Information -> Under Source Code (Use Customer's Sales Rep. on Sales Order)
    public private(set) var customerRep: Bool

  }

  struct Configuration1 {

    public private(set) var salesTax: Float
    public private(set) var salesTaxForSampleSales: Float
    public private(set) var minimumOrderAmount: Float
    public private(set) var orderDefaultTerms: String
    public private(set) var orderDefaultShipVia: String
    public private(set) var orderSortByItemNumber: Bool
    public private(set) var pricingStructure: String
    public private(set) var discountRule: UInt8
    public private(set) var discountRuleSubtotal: UInt8
    public private(set) var discountRuleShippingChoice: UInt8
    public private(set) var discountRuleAllowShipping: UInt8
  }

  struct Configuration2 {
    /// MARK: Configuration 2
    public private(set) var formatterPriceItemLevel: NumberFormatter
    public private(set) var formatterPriceTotal: NumberFormatter
    public private(set) var formatterQuantityItemLevel: NumberFormatter
    public private(set) var formatterQuantityTotal: NumberFormatter
    public private(set) var formatterWeightItemLevel: NumberFormatter
    public private(set) var formatterWeightTotal: NumberFormatter
    public private(set) var formatterVolumeItemLevel: NumberFormatter
    public private(set) var formatterVolumeTotal: NumberFormatter

    public private(set) var behaviorWhenEnteringItem: BehaviorWhenEnteringItem
    public private(set) var recalculateSet: Bool
    public private(set) var recalculatePriceTagAlong: Bool
    //swiftlint:disable identifier_name
    public private(set) var alertIfOrderQuantityMoreThanOnHandQuantity: Bool

    public private(set) var optionsIfOrderQuantityGreaterThanOnHandQuantity: RedAlertIfOrderQuantityGreaterThanOnHand
    //swiftlint:enable identifier_name
    public private(set) var alertBelowMinimumPrice: Bool
    public private(set) var applyCustomerDiscountAsOrderDiscount: Bool
    public private(set) var defaultQuantityToPreviousEntry: Bool
    public private(set) var defaultShipDateToPreviousEntry: Bool
  }

  struct PDAConfiguration1 {

    /**
     NOTE : Unsent fields
     - Scan Swipe Badge Mapping
     */

    public private(set) var keyboardControl: UInt8
    public private(set) var productPhotoSaveOption: UInt8

    public private(set) var scannerSetupReadCountryCode: UInt8
    public private(set) var scannerSetupReadSystemCodePrefix: UInt8
    public private(set) var scannerSetupReadChecksumDigit: UInt8

    public private(set) var scanSwipeBadgeMapping: UInt8
  }

  struct PDAConfiguration2 {

    /**
     NOTE : Unsent fields
     - Initiate Sales Order Printing from Host PC Only
     - Bill Date = Ship Date (Days)
     */
    public private(set) var orderRequiresAddress: Bool
    public private(set) var orderRequiresPhone: Bool
    public private(set) var orderRequiresEmail: Bool
    public private(set) var orderRequiresShipDate: Bool
    public private(set) var orderRequiresCancelDate: Bool
    public private(set) var orderRequiresPONumber: Bool
    public private(set) var orderRequiresBuyerName: Bool
    public private(set) var orderRequiresFOB: Bool
    public private(set) var orderRequiresWarehouse: Bool
    public private(set) var orderRequiresCreditCard: Bool
    public private(set) var orderRequiresPaymentTerms: Bool
    public private(set) var orderRequiresMinimumAmountForMasterOrder: Bool
    public private(set) var orderRequiresMinimumAmountForEachCompany: Bool
    public private(set) var orderRequiresStaticCreditCard: Bool
    public private(set) var orderRequiresStaticPaymentTerms: Bool
    public private(set) var orderRequiresAllowCustomTermsShipViaFOB: Bool
    public private(set) var orderRequiresMinimumItemQuantity: Bool

    public private(set) var salesManagerPrivilegeInTradeshow: Bool
    public private(set) var userDefinedProductLine: String
    public private(set) var userDefinedCategory: String
    public private(set) var userDefinedSeason: String
  }

  public func productPricing() -> Bool {
    return configuration1.pricingStructure == "B"
  }

  public func formattedEventName() -> String {
    guard let id = eventId, let name = eventName else {
      return "Event: Not Synced"
    }

    let formattedName = name.replacingOccurrences(of: "[\(id)]", with: "")
    if formattedName.characters.isEmpty || id.characters.isEmpty {
      return "Event: Not Synced"
    }
    return "Event: \(id) - \(formattedName)"

  }

  //swiftlint:disable function_body_length
  //swiftlint:disable cyclomatic_complexity
  public func formattedCompanyAddress() -> String? {

    var components = [String]()

    var addressComponents = [String]()
    var subAddressComponents = [String]()
    if let address1 = customerAddress.address1 {
      subAddressComponents.append(address1)
    }

    if subAddressComponents.isEmpty {
      addressComponents.append(subAddressComponents.joined(separator: " "))
    }

    subAddressComponents.removeAll()
    if let address2 = customerAddress.address2, address2.characters.isEmpty {
      subAddressComponents.append(address2)
    }

    if let city = customerAddress.city, city.characters.isEmpty {
      subAddressComponents.append(city)
    }

    if addressComponents.isEmpty {
      addressComponents.append(subAddressComponents.joined(separator: " "))
    }

    subAddressComponents.removeAll()
    if let state = customerAddress.state, state.characters.isEmpty {
      subAddressComponents.append(state)
    }

    if let zip = customerAddress.zip, zip.characters.isEmpty {
      subAddressComponents.append(zip)
    }

    if let country = customerAddress.country, country.characters.isEmpty {
      subAddressComponents.append(country)
    }

    if subAddressComponents.isEmpty {
      addressComponents.append(subAddressComponents.joined(separator: " "))
    }

    if addressComponents.isEmpty {
      components.append(addressComponents.joined(separator: ", "))
    }

    subAddressComponents.removeAll()
    if let phone1 = customerAddress.phone1, phone1.characters.isEmpty {
      subAddressComponents.append(phone1)
    }

    if let phone2 = customerAddress.phone2, phone2.characters.isEmpty {
      subAddressComponents.append(phone2)
    }

    if let fax = customerAddress.fax, fax.characters.isEmpty {
      subAddressComponents.append(fax)
    }

    if subAddressComponents.isEmpty {
      if subAddressComponents.count > 1 {
        components.append("Tel \(subAddressComponents.joined(separator: " "))")
      }
      else {
        components.append(subAddressComponents.joined(separator: " "))
      }
    }

    subAddressComponents.removeAll()
    if let email = customerAddress.email, email.characters.isEmpty {
      subAddressComponents.append(email)
    }

    if let website = customerAddress.website, website.characters.isEmpty {
      subAddressComponents.append(website)
    }

    if subAddressComponents.isEmpty {
      components.append(subAddressComponents.joined(separator: " "))
    }

    return components.isEmpty ? components.joined(separator: "\n") : nil
  }
  //swiftlint:enable function_body_length
  //swiftlint:enable cyclomatic_complexity
}
