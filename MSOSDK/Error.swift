//
//  Error.swift
//  MSOSDK
//
//  Created by John Setting on 5/22/17.
//  Copyright © 2017 Logiciel Inc. All rights reserved.
//

import Foundation

struct MSOSDKError: Error {

  let domain: String
  let code: UInt
  let description: String
  let reason: String

  static func invalidCredentials() -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                       code: 204,
                       description: "Login Failed",
                       reason: "Your login credentials are incorrect. Please verify your username and password are correct")
  }

  static func ping() -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                            code: 204,
                            description: "Netserver Ping Error",
                            reason: "There was an error checking if netserver is available. Please try again")
  }

  static func outOfMemory() -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                       code: 204,
                       description: "Netserver Out of Memory Error",
                       reason: "Netserver seems to be out of memory. Please reboot netserver and try again")
  }

  static func productFetchEmptyResults() -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                            code: 204,
                            description: "Product Search Error",
                            reason: "No Results Found")
  }

  static func invalidEvent() -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                       code: 204,
                       description: "Event Invalid",
                       reason: "Please refresh your event since the current event in MSO does not match what is on the iPad")
  }

  static func eventUpdated(_ eventName: String, eventId: String) -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                       code: 204,
                       description: "Event Updated",
                       reason: "Updated current event on the iPad to '\(eventName) (\(eventId))'.\nPlease log-in again")

  }

  static func salesOrderTotal() -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                       code: 204,
                       description: "Sales Order Error",
                       reason: "The current order's value is too low. Ensure that your order's total results in a value greater than $0.00")

  }

  static func unknownFormat(_ data: String) -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                       code: 204,
                       description: "Netserver Unknown Format Error",
                       reason: "\(unknownFormat)")

  }

  static func imageNotFound() -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                       code: 204,
                       description: "No Photo Found",
                       reason: "You can add a photo for this item in MSO is necessary then re-download the product image")

  }

  static func customerQueryExceededLimit() -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                       code: 204,
                       description: "Exceeded Search Limit with MSO",
                       reason: "The return result exceeded the limit (200). Please make a more specific search to retrieve customers from MSO")

  }


  static func customerQueryNotFound() -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                       code: 204,
                       description: "No Customer(s) Found",
                       reason: "Try different search methods and also check MSO to see if there in fact does contain a customer with the exact search criteria")

  }

  static func salesOrdersNotFound() -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                       code: 204,
                       description: "No Sales Orders Found",
                       reason: "There were no sales orders found for the specified search critera")
  }


  static func salesOrderNotFound() -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                       code: 204,
                       description: "No Sales Order Found",
                       reason: "There was no sales order found for the specified order number")
  }

  static func imageUpload() -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                       code: 204,
                       description: "Netserver Image Upload",
                       reason: "No Photo was submitted. Please try again")
  }

  static func autoMappingNotCreated() -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                       code: 204,
                       description: "Customer Mapping Error",
                       reason: "No Auto-Mapping Created. The format was invalid")
  }

  static func autoMappingNotUpdated() -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                       code: 204,
                       description: "Customer Mapping Error",
                       reason: "No mapping was updated. The format was invalid")
  }

  static func methodRequest(_ action: String) -> MSOSDKError {
    let formatted = action.components(separatedBy: "/").last ?? ""
    return MSOSDKError(domain: URLError.errorDomain,
                       code: 204,
                       description: "Error Retrieving Data",
                       reason: "Please inform Logiciel there was an issue with requesting data from MSO reguarding action : \(formatted)")

  }

}
