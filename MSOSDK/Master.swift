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

  private func validate(_ data: String?, command: String?, status: String?) throws -> Bool {

    var validity = false

    guard let data = data else {
      return validity
    }

    do {
      validity = try validateCredentials(data, command: command, status: status)
      validity = try validateResults(data, command: command, status: status)
      return validity
    }
    catch let e {
      throw e
    }

  }

  private func validateCredentials(_ data: String, command: String?, status: String?) throws -> Bool {

    if data.hasPrefix("Invalid Login:") ||
      data.hasPrefix("Invalid ID/Password or Access Level.") {
      throw MSOSDKError.invalidCredentials()
    }

    if data.hasPrefix("Invalid Event:") {
      throw MSOSDKError.invalidEvent()
    }

    if data.hasPrefix("Invalid Event.") {
      throw MSOSDKError.eventUpdated(command ?? "", eventId: status ?? "")
    }

    return true
  }

  private func validateResults(_ data: String, command: String?, status: String?) throws -> Bool {

    if data.hasPrefix("Unknown Format:") {

      if command == "_O002" {
        if data.hasSuffix("*****Error Message: Value was either too large or too small for a Decimal.") {
          throw MSOSDKError.salesOrderTotal()
        }
      }

      if data.contains("OutOfMemoryException") {
        throw MSOSDKError.outOfMemory()
      } else {
        throw MSOSDKError.unknownFormat(data)
      }
    }

    if data == "Item Not Found." {
      throw MSOSDKError.productFetchEmptyResults()
    }

    if data == "Photo Not Found" {
      throw MSOSDKError.imageNotFound()
    }

    if data == "Exceeded Limit" {
      throw MSOSDKError.customerQueryExceededLimit()
    }

    if data == "No Customer Found." {
      throw MSOSDKError.customerQueryNotFound()
    }
    
    if data.hasSuffix("No Customer Updated.") {
      throw MSOSDKError.customerQueryNotFound()
    }

    if command == "_E004", data == "No Sales Order Found." {
      throw MSOSDKError.salesOrdersNotFound()
    }

    if command == "_O001", data == "No Sales Order Found." {
      throw MSOSDKError.salesOrderNotFound()
    }

    if command == "_P011", data == "Item Not Found" {
      throw MSOSDKError.imageUpload()
    }

    if command == "_C006", data.hasSuffix("No Auto-Mapping Created.") {
      throw MSOSDKError.autoMappingNotCreated()
    }

    if command == "_C007", data.hasSuffix("Index was outside the bounds of the array.") {
      throw MSOSDKError.autoMappingNotUpdated()
    }

    if let status = status {

      guard let command = command else {
        throw MSOSDKError.methodRequest("")
      }

      if status == "NO" {
        throw MSOSDKError.methodRequest(command)
      }

    }


    return true

  }

  private func urlRequestForImage(url: String, timeout: TimeInterval = 10, error: NSErrorPointer) -> URLRequest {
    let serializer = AFHTTPRequestSerializer()
    serializer.timeoutInterval = timeout

    let request = serializer.request(withMethod: "GET", urlString: url, parameters: nil, error: error)

    return request as URLRequest
  }

  func urlRequest(parameters: [SoapParameter],
                  type: String,
                  url: URL,
                  netserver: Bool,
                  timeout: TimeInterval = 10,
                  error: NSErrorPointer) -> URLRequest {

    var parameterArray = [String]()
    var namespace: String

    if netserver {

      let format = " must be set. Use + (void)setMSONetserverIPAddress:(NSString *)msoNetserverIPAddress " +
      "msoDeviceName:(NSString *)msoDeviceName " +
      "msoDeviceIpAddress:(NSString *)msoDeviceIpAddress " +
      "msoEventId:(NSString *)msoEventId"

      guard let deviceName = deviceName else {
        fatalError("deviceName".appending(format))
      }

      guard let deviceIp = deviceIp else {
        fatalError("deviceIp".appending(format))
      }

      guard let eventId = eventId else {
        fatalError("eventId".appending(format))
      }

      let client = "\(deviceName) [\(deviceIp)]{SQL05^\(eventId)}#iPad#"
//      client = client.buildCommand()
      let clientParameter = SoapParameter(withObject: client, forKey: "client")
      parameterArray.append(clientParameter.xml())

      namespace = Constants.URL.baseIncUrl
    }
    else {
      namespace = Constants.URL.baseUrl
    }

    var actionUrl = URL(string: namespace)
    actionUrl = actionUrl?.appendingPathComponent(type)

    for parameter in parameters {
      parameterArray.append(parameter.xml())
    }

    let parameterString = parameterArray.joined(separator: "\n")
    let soapMessage = createEnvelope(withMethod: type /*need to write lastPathComponent()*/, namespace: namespace, parameters: parameterString)

    let serializer = AFHTTPRequestSerializer()
    serializer.timeoutInterval = timeout
    serializer.setValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
    serializer.setValue("\(soapMessage)", forHTTPHeaderField: "Content-Length")
    serializer.setValue(actionUrl?.absoluteString, forHTTPHeaderField: "SOAPAction")

    let request = serializer.request(withMethod: "POST",
                                     urlString: url.absoluteString,
                                     parameters: nil,
                                     error: error)
    request.httpBody = soapMessage.data(using: Constants.URL.encoding)
    return request as URLRequest
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
