//
//  Constants.swift
//  MSOSDK
//
//  Created by John Setting on 5/22/17.
//  Copyright © 2017 Logiciel Inc. All rights reserved.
//

import Foundation

struct Constants {

  struct Timeouts {

    static let veryshort = 5
    static let short = 15
    static let regular = 30
    static let long = 60
    static let verylong = 90

    static let allImageSync = verylong
    static let catalogSync = short

    static let customerSave = long
    static let customerSync = verylong
    static let customerSearch = long

    static let dataRequest = short

    static let forgotPassword = short
    static let imageSync = regular
    static let imageUpload = long

    static let login = short
    static let ping = veryshort

    static let productSync = verylong

    static let purchaseHistory = long
    static let registration = long
    static let salesOrder = long
    static let scanner = veryshort
    static let settingsSync = verylong

  }

  struct URL {

    static let logicielHTTPURL = "http://logicielinc.com/PUBLIC/Customer_Auto_FTP/"
    static let encoding = String.Encoding.utf8
    static let baseIncUrl = "http://logicielinc.com"
    static let baseUrl = "http://logiciel.com/"

    //swiftlint:disable nesting
    struct Function {

      static let doWork = "IServiceLibrary/DoWork"

      static let registerCode = "iRegisterCode"
      static let uploadFile = "_UploadFile"
      static let updateUploadInfo = "_UpdateUploadInfo"
      static let registerShortKey = "iRegisterShortKey"
      static let checkMobileDevice = "iCheckMobileDevice"
      static let checkMobileUser = "iCheckMobileUser"
      static let checkPDAMessage = "_iCheckPDAMessage"
      static let checkCatalogFileStatus = "_CheckCatalogFileStatus"
      static let getCustomersByCompany = "GetCustomersByCompany"
      static let checkPDAHistoryForDownloading = "_iCheckPDAHistoryForDownloading"
      static let updateDownloadInfo = "_UpdateDownloadInfo"
      static let checkMobileMessage = "_iCheckMobileMessage"
      static let checkMobileFileForDownloading = "_iCheckMobileFileForDownloading"
      static let getEventList = "GetEventList"
      static let checkPhotoFileStatus = "_CheckPhotoFileStatus"

    }

    struct Endpoint {

      static let updateEndpoint = "logicielupdatews"
      static let customerASMX = "logicielcustomer.asmx"
      static let ftpWSEndpoint = "logiciel_ftp_ws"
      static let ftpServiceASMX = "FTPService.asmx"

    }
    //swiftlint:enable nesting

  }

  struct Command {

    static let ping = "<*!BEGIN!*><~~>_S001^^WLAN Connection?<*!END!*>"
    static let logout = "<*!BEGIN!*><~~><*!END!*>"

    static let beginEscaped = "&amp;lt;*!BEGIN!*&amp;gt;"
    static let endEscaped = "&amp;lt;*!END!*&amp;gt;"

    static let begin = "<*!BEGIN!*><~~>"
    static let end = "<*!END!*>"

  }

}

/**
 enums that define a product search type. This is only applied to Netserver Product Requests

 - kMSOProductSearchTypeItemNumber: Search By Item #
 - kMSOProductSearchTypeDescription: Search By Description
 - kMSOProductSearchTypeColor: Search By Color
 - kMSOProductSearchTypeSize: Search By Size
 - kMSOProductSearchTypeProductInfo: Search By Product Info (product line | category | season) for all companies
 - kMSOProductSearchTypeUserDefined: Search By User Defined Fields, (e.g N| = new item, S| = special item, H| hot item)
 */
enum ProductSearchType: UInt8 {

  case itemNumber
  case description
  case color
  case size
  case productInfo
  case userDefined

}

/**
 enums that define the registration status of an access key. This is only applied to Web Service calls

 - kMSOSDKResponseWebserverStatusNotFound: Status Not Found = 0
 - kMSOSDKResponseWebserverStatusUnregistered: Status Unregistered = 00
 - kMSOSDKResponseWebserverStatusExpired: Status Expired = 1
 - kMSOSDKResponseWebserverStatusDisabled: Status Disabled = 11
 - kMSOSDKResponseWebserverStatusSuspended: Status Suspended = -1
 - kMSOSDKResponseWebserverStatusInvalid: Status Invalid = -2
 - kMSOSDKResponseWebserverStatusSuccess: Status Success = 2
 - kMSOSDKResponseWebserverStatusUnknown: Status Unknown = ?
 */
enum WebserverStatus: UInt8 {
  case notFound
  case unregistered
  case expired
  case disabled
  case suspended
  case invalid
  case success
}

enum RequestType: UInt8 {
  case netserver
  case webserver
}

/**
 A progress block used within blocks to signal progression of a methods action

 @param progress An NSProgress object
 */
typealias MSOProgressBlock = (_ progress: Progress) -> Void

/**
 A success block used to signal a method has successfully finished with no errors

 @param response The URLResponse of the block
 @param responseObject A nullable object. It will only be null if there is a handler within the block to process that data
 */
typealias MSOSuccessBlock = (_ response: URLResponse, _ responseObject: Any?) -> Void

/**
 A failure block used to signal a method has failed with an error

 @param response The URLResponse of the block
 @param error A nonnull error object
 */
typealias MSOFailureBlock = (_ response: URLResponse, _ error: Error) -> Void

typealias MSOHandlerBlock = (_ response: URLResponse, _ responseObject: Any) throws -> Void
