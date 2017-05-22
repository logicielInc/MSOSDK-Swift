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

struct Netserver {

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

    public private(set) var bulkSellingDescription: String

    /// MARK: Customer
    public private(set) var lastPurchasePricePriority: String

    /// MARK: S.O. Message
    public private(set) var companyPolicy: String
    public private(set) var customerGreeting: String
    public private(set) var payment: String

    public private(set) var customizedSO: CustomizedSO
    public private(set) var configuration1: Configuration1
    public private(set) var configuration2: Configuration2
    public private(set) var pdaConfiguration1: PDAConfiguration1
    public private(set) var pdaConfiguration2: PDAConfiguration2

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
    struct CustomizedSO {

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

      struct Formatter {

        public private(set) var priceItemLevel: NumberFormatter
        public private(set) var priceTotal: NumberFormatter
        public private(set) var quantityItemLevel: NumberFormatter
        public private(set) var quantityTotal: NumberFormatter
        public private(set) var weightItemLevel: NumberFormatter
        public private(set) var weightTotal: NumberFormatter
        public private(set) var volumeItemLevel: NumberFormatter
        public private(set) var volumeTotal: NumberFormatter

      }

      /**
       @brief MSO will return back 3 results: Always Append, Always Retrieve, Offer Choice
       */
      enum BehaviorWhenEnteringItem: UInt8 {
        case append
        case retrieve
        case choice
      }

      public private(set) var behaviorWhenEnteringItem: BehaviorWhenEnteringItem
      public private(set) var recalculateSet: Bool
      public private(set) var recalculatePriceTagAlong: Bool
      public private(set) var alertIfOrderQuantityMoreThanOnHandQuantity: Bool

      /**
       @brief MSO will return back 3 results: Item Setup, Back Order, Offer Choice
       */
      enum RedAlertIfOrderQuantityGreaterThanOnHand: UInt8 {
        case itemSetup
        case backorder
        case choice
      }

      public private(set) var optionsIfOrderQuantityGreaterThanOnHandQuantity: RedAlertIfOrderQuantityGreaterThanOnHand;
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

      struct OrderRequirements {

        public private(set) var address: Bool
        public private(set) var phone: Bool
        public private(set) var email: Bool
        public private(set) var shipDate: Bool
        public private(set) var cancelDate: Bool
        public private(set) var poNumber: Bool
        public private(set) var buyerName: Bool
        public private(set) var fob: Bool
        public private(set) var warehouse: Bool
        public private(set) var creditCard: Bool
        public private(set) var paymentTerms: Bool
        public private(set) var minimumOrderAmountForMasterOrder: Bool
        public private(set) var minimumOrderAmountForEachCompany: Bool
        public private(set) var staticCreditCard: Bool
        public private(set) var staticPaymentTerms: Bool
        public private(set) var allowCustomTermsShipViaFOB: Bool
        public private(set) var minimumItemQuantity: Bool

      }

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
      if formattedName.characters.count == 0 || id.characters.count == 0 {
        return "Event: Not Synced"
      }
      return "Event: \(id) - \(formattedName)"

    }

    public func formattedCompanyAddress() -> String? {

      var components = [String]()

      var addressComponents = [String]()
      var subAddressComponents = [String]()
      if let address1 = address1 {
        subAddressComponents.append(address1)
      }

      if subAddressComponents.count > 0 {
        addressComponents.append(subAddressComponents.joined(separator: " "))
      }

      subAddressComponents.removeAll()
      if let address2 = address2, address2.characters.count > 0 {
        subAddressComponents.append(address2)
      }

      if let city = city, city.characters.count > 0 {
        subAddressComponents.append(city)
      }

      if addressComponents.count > 0 {
        addressComponents.append(subAddressComponents.joined(separator: " "))
      }

      subAddressComponents.removeAll()
      if let state = state, state.characters.count > 0 {
        subAddressComponents.append(state)
      }

      if let zip = zip, zip.characters.count > 0 {
        subAddressComponents.append(zip)
      }

      if let country = country, country.characters.count > 0 {
        subAddressComponents.append(country)
      }

      if subAddressComponents.count > 0 {
        addressComponents.append(subAddressComponents.joined(separator: " "))
      }

      if addressComponents.count > 0 {
        components.append(addressComponents.joined(separator: ", "))
      }

      subAddressComponents.removeAll()
      if let phone1 = phone1, phone1.characters.count > 0 {
        subAddressComponents.append(phone1)
      }

      if let phone2 = phone2, phone2.characters.count > 0 {
        subAddressComponents.append(phone2)
      }

      if let fax = fax, fax.characters.count > 0 {
        subAddressComponents.append(fax)
      }

      if subAddressComponents.count > 0 {
        if subAddressComponents.count > 1 {
          components.append("Tel \(subAddressComponents.joined(separator: " "))")
        }
        else {
          components.append(subAddressComponents.joined(separator: " "))
        }
      }

      subAddressComponents.removeAll()
      if let email = email, email.characters.count > 0 {
        subAddressComponents.append(email)
      }

      if let website = website, website.characters.count > 0 {
        subAddressComponents.append(website)
      }

      if subAddressComponents.count > 0 {
        components.append(subAddressComponents.joined(separator: " "))
      }

      return components.count > 0 ? components.joined(separator: "\n") : nil
    }

  }
}
