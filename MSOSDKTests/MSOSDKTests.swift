//
//  MSOSDKTests.swift
//  MSOSDKTests
//
//  Created by John Setting on 5/22/17.
//  Copyright © 2017 Logiciel Inc. All rights reserved.
//

import Quick
import Nimble
@testable import MSOSDK

class MSOSDKTests: QuickSpec {

  override func spec() {

    context("struct initializers") {

      context("netserver") {

        describe("Ping") {

          it("will throw ping error") {
            expect { try Ping("") }.to(throwError(MSOSDKError.ping()))
          }
          it("will throw credentials error") {
            expect { try Ping("Invalid Login: Invalid ID/Password or Access Level.") }.to(throwError(MSOSDKError.invalidCredentials()))
          }
          it("will throw out of memory exception") {
            expect { try Ping("OutOfMemoryException") }.to(throwError(MSOSDKError.outOfMemory()))
          }
          it("will throw updated event exception") {
            expect { try Ping("Invalid Event. [130h] Johns Event") }.to(throwError(MSOSDKError.eventUpdated("Johns Event", eventId: "103h")))
          }
          it("will not throw exception") {
            expect { try Ping("[130h] Johns Event") }.toNot(throwError())
          }

        }

      }
    }
  }
}
