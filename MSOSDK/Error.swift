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

  static func ping() -> MSOSDKError {
    return MSOSDKError(domain: URLError.errorDomain,
                            code: 204,
                            description: "Netserver Ping Error",
                            reason: "There was an error checking if netserver is available. Please try again")
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

}
