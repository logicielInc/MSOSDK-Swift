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

    /// MARK: Customized S.O.
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
    public private(set) var printUCP: Bool
    public private(set) var printDescription2: Bool
    public private(set) var printItemVendorName: Bool
    public private(set) var printManufacturerName: Bool
    public private(set) var printOrderTotal: Bool
    public private(set) var printSortByItemNumber: Bool
    public private(set) var printMSRP: Bool
    public private(set) var printPrice: Bool
    public private(set) var printItemColorSizeAbbreviation: Bool
    public private(set) var printItemWeight: Bool
    public private(set) var printTotalWeight: Bool
    public private(set) var printItemVolume: Bool
    public private(set) var printTotalVolume: Bool
    public private(set) var printItemDiscountIfDiscounted: Bool
    public private(set) var printIfBulkSellingShowQuantity: Bool
    public private(set) var printIfBulkSellingShowPrice: Bool

    /// This is shown in Event -> Setup -> Information -> Under Source Code (Use Customer's Sales Rep. on Sales Order)
    public private(set) var printCustomerRep: Bool

    /// MARK: Configuration 1 
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

    /// MARK: PDA Configuration 1
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

    /// MARK: PDA Configuration 2
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

    public func productPricing() -> Bool {
      return pricingStructure == "B"
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
      if let address1 = address1 {
        subAddressComponents.append(address1)
      }

      if subAddressComponents.isEmpty {
        addressComponents.append(subAddressComponents.joined(separator: " "))
      }

      subAddressComponents.removeAll()
      if let address2 = address2, address2.characters.isEmpty {
        subAddressComponents.append(address2)
      }

      if let city = city, city.characters.isEmpty {
        subAddressComponents.append(city)
      }

      if addressComponents.isEmpty {
        addressComponents.append(subAddressComponents.joined(separator: " "))
      }

      subAddressComponents.removeAll()
      if let state = state, state.characters.isEmpty {
        subAddressComponents.append(state)
      }

      if let zip = zip, zip.characters.isEmpty {
        subAddressComponents.append(zip)
      }

      if let country = country, country.characters.isEmpty {
        subAddressComponents.append(country)
      }

      if subAddressComponents.isEmpty {
        addressComponents.append(subAddressComponents.joined(separator: " "))
      }

      if addressComponents.isEmpty {
        components.append(addressComponents.joined(separator: ", "))
      }

      subAddressComponents.removeAll()
      if let phone1 = phone1, phone1.characters.isEmpty {
        subAddressComponents.append(phone1)
      }

      if let phone2 = phone2, phone2.characters.isEmpty {
        subAddressComponents.append(phone2)
      }

      if let fax = fax, fax.characters.isEmpty {
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
      if let email = email, email.characters.isEmpty {
        subAddressComponents.append(email)
      }

      if let website = website, website.characters.isEmpty {
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
}
