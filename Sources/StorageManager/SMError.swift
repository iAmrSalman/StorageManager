//
//  SMError.swift
//  StorageManager
//
//  Created by Amr Salman on 1/26/18.
//  Copyright © 2018 StorageManager. All rights reserved.
//

import Foundation

public enum SMError: Error {
    case missing(String)
    case invalid(String, Any?)
    case wrong(String)
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
        case .unkown:
            return "Unkown error"
        }
    }
}
