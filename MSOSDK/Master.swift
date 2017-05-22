//
//  Master.swift
//  MSOSDK
//
//  Created by John Setting on 5/22/17.
//  Copyright © 2017 Logiciel Inc. All rights reserved.
//

import Foundation
import AFNetworking

final class Master {

  static let shared = Master()

  var operation: AFHTTPSessionManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration())
  var authUsername: String?
  var authPassword: String?
  private var ipAddress: String?
  private var deviceName: String?
  private var deviceIp: String?
  private var eventId: String?
  private var password: String? = "logic99"

  private var serviceUrl: URL? {
    guard let ip = ipAddress else {
      fatalError("There must be a netserver IP Address set." +
        "Use + (void)setMSONetserverIPAddress:(NSString *)msoNetserverIPAddress")
    }
    let urlString = "http://\(ip):8178/LogicielNetServer"
    let url = URL(string: urlString)
    return url
  }

  init() {

    //swiftlint:disable line_length
    operation.setTaskDidReceiveAuthenticationChallenge { [weak self] _, _, challenge, _ -> URLSession.AuthChallengeDisposition in
    //swiftlint:enable line_length

      guard let strongSelf = self, let sender = challenge.sender else {
        return .cancelAuthenticationChallenge
      }

      if challenge.previousFailureCount == 0,
        let authUsername = strongSelf.authUsername,
        let authPassword = strongSelf.authPassword {

        let newCredential = URLCredential(user: authUsername,
                                          password: authPassword,
                                          persistence: .none)
        sender.use(newCredential, for: challenge)
        return .useCredential

      }
      else {
        sender.cancel(challenge)
        return .cancelAuthenticationChallenge
      }

    }

    let responseSerializer = AFHTTPResponseSerializer()
    operation.responseSerializer = responseSerializer

    let policy = AFSecurityPolicy(pinningMode: .none)
    policy.validatesDomainName = false
    policy.allowInvalidCertificates = true
    operation.securityPolicy = policy

  }

  public func setMSOCredentials(_ ipAddress: String? = nil,
                                deviceName: String? = nil,
                                deviceIp: String? = nil,
                                eventId: String? = nil,
                                password: String? = "logic99",
                                authUsername: String? = nil,
                                authPassword: String? = nil) {

    self.ipAddress = ipAddress
    self.deviceName = deviceName
    self.deviceIp = deviceIp
    self.eventId = eventId
    self.password = password
    self.authUsername = authUsername
    self.authPassword = authPassword

  }

  private func createEnvelope(withMethod method: String,
                              namespace: String,
                              parameters: String) -> String {

    var soapBody = String()
    soapBody.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n")
    soapBody.append("<soap:Envelope " +
      "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" " +
      "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" " +
      "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n")
    soapBody.append("<soap:Body>\n")
    soapBody.append("<\(method) xmlns=\"\(namespace)\">\n")
    soapBody.append("\(parameters.replacingOccurrences(of: "&", with: "&amp;"))\n")
    soapBody.append("</\(method)>\n")
    soapBody.append("</soap:Body>\n")
    soapBody.append("</soap:Envelope>\n")
    return soapBody

  }
}

struct SoapParameter {

  public private(set) var object: Any?
  public private(set) var key: String

  init(withObject object: Any, forKey: String) {
    self.object = object
    self.key = forKey
  }

  func xml() -> String {

    guard let object = object else {
      return "<\(key) xsi:nil=\"true\"/>"
    }

    return serialize(object, key: key)
  }

  private func serialize(_ object: Any, key: String) -> String {
    return "<\(key)>\(serialize(object))</\(key)>"
  }

  private func serialize(_ object: Any) -> Any {

    if let object = object as? Date {
      let formatter = DateFormatter.longFormatter
      return formatter.string(from: object)
    }

    if let object = object as? Data {
      return object.base64EncodedString(options: [.endLineWithCarriageReturn, .endLineWithLineFeed])
    }

    if let object = object as? UIImage, let data = UIImagePNGRepresentation(object) {
      let formatted = data.base64EncodedString()
      return formatted
    }

    return object
  }

}
