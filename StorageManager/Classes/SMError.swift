//
//  SMError.swift
//  Pods
//
//  Created by Amr Salman on 9/23/17.
//
//

import Foundation

import Foundation

enum SMError: Error {
  case missing(String)
  case invalid(String, Any?)
  case wrong(String)
  case connection
  case unkown
}

extension SMError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .missing(let str):
      return "\(str) is missing"
    case .invalid(let title, let object):
      return "invalid \(title), object: \(object.debugDescription)"
    case .wrong(let str):
      return "Wrong \(str)"
    case .connection:
      return "Internet connection is required!"
    case .unkown:
      return "Unkown error"
    }
  }
}
