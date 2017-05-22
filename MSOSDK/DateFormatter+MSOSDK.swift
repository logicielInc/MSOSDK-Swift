//
//  DateFormatter+MSOSDK.swift
//  MSOSDK
//
//  Created by John Setting on 5/22/17.
//  Copyright © 2017 Logiciel Inc. All rights reserved.
//

import Foundation

extension DateFormatter {

  static var longFormatter: DateFormatter {

    let formatter = DateFormatter()
    let locale = Locale(identifier: "en_US")
    formatter.locale = locale
    formatter.isLenient = true
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    return formatter

  }

  static var mediumFormatter: DateFormatter {

    let formatter = DateFormatter()
    let locale = Locale(identifier: "en_US")
    formatter.locale = locale
    formatter.isLenient = true
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter

  }

}
