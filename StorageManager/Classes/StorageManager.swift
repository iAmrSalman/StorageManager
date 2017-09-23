//
//  StorageManager.swift
//  Pods
//
//  Created by Amr Salman on 9/23/17.
//
//

import UIKit

enum JSONType {
  case array
  case dictionary
}

class StorageManager {
  
  static let `default` = StorageManager()
  
  //MARK: - Helpers
  
  fileprivate func getUrl(forKey key: String) throws -> URL? {
    guard let url = UserDefaults.standard.url(forKey: key) else {
      do {
        return try getDataUrl(key)
      } catch {
        throw error
      }
    }
    print("[StorageManager] \(url)")
    return url
  }
  
  fileprivate func getDataUrl(_ key: String) throws -> URL? {
    do {
      let document = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
      let targetUrl = document.appendingPathComponent("\(key).json")
      UserDefaults.standard.set(targetUrl, forKey: key)
      
      return targetUrl
      
    } catch {
      throw error
    }
    
  }
  
  fileprivate func getJSONDictinary(_ key: String) throws -> [String: Any]? {
    do {
      guard let fileUrl = try getUrl(forKey: key) else { return nil }
      
      do {
        if let jsonData = try? Data(contentsOf: fileUrl) {
          let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
          
          return jsonResult
        } else {
          return nil
        }
      } catch {
        throw error
      }
      
    } catch {
      throw error
    }
  }
  
  fileprivate func getJSONArray(_ key: String) throws -> [Any]? {
    do {
      guard let fileUrl = try getUrl(forKey: key) else { return nil }
      
      do {
        if let jsonData = try? Data(contentsOf: fileUrl) {
          let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [Any]
          
          return jsonResult
        } else {
          return nil
        }
      } catch {
        throw error
      }
      
    } catch {
      throw error
    }
  }
  
  fileprivate func getJSONText(fromDictionary dictionary: [String: Any]) throws -> String? {
    do {
      let theJSONData = try
        JSONSerialization.data(withJSONObject: dictionary ,options: JSONSerialization.WritingOptions.prettyPrinted)
      let theJSONText = String(data: theJSONData, encoding: String.Encoding.utf8)
      return theJSONText
    } catch {
      throw error
    }
  }
  
  fileprivate func getJSONText(fromArray array: [Any]) throws -> String? {
    do {
      let theJSONData = try
        JSONSerialization.data(withJSONObject: array ,options: JSONSerialization.WritingOptions.prettyPrinted)
      let theJSONText = String(data: theJSONData, encoding: String.Encoding.utf8)
      return theJSONText
    } catch {
      throw error
    }
  }
  
  fileprivate func write(jsonText: String?, toUrl url: URL?) throws {
    guard let unwrappedURL = url else { throw SMError.invalid("URL", url) }
    do {
      try jsonText?.write(to: unwrappedURL , atomically: true, encoding: String.Encoding.utf8)
    } catch {
      throw error
    }
  }
  
  //MARK: - Actions
  
  func store(dictionary: [String: Any], in fileName: String) throws {
    do {
      try write(jsonText: try getJSONText(fromDictionary: dictionary), toUrl: try getUrl(forKey: fileName))
    } catch {
      throw error
    }
  }
  
  func store(array: [Any], in fileName: String) throws {
    do {
      try write(jsonText: try getJSONText(fromArray: array), toUrl: try getUrl(forKey: fileName))
    } catch {
      throw error
    }
  }
  
  func store(data: Data, jsonType: JSONType, in fileName: String) throws {
    switch jsonType {
    case .array:
      do {
        guard let array = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [Any] else { throw SMError.invalid(fileName, jsonType) }
        try write(jsonText: try getJSONText(fromArray: array), toUrl: try getUrl(forKey: fileName))
      } catch {
        throw error
      }
    case .dictionary:
      do {
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] else { throw SMError.invalid(fileName, jsonType) }
        try write(jsonText: try getJSONText(fromDictionary: dictionary), toUrl: try getUrl(forKey: fileName))
      } catch {
        throw error
      }
    }
  }
  
  func update<T>(vlaue: T, forKey key: String, `in` fileName: String) throws {
    do {
      var dictionary = try StorageManager.default.dictionaryValue(fileName)
      dictionary[key] = vlaue
      try StorageManager.default.store(dictionary: dictionary, in: fileName)
    } catch {
      throw error
    }
  }
  
  func clear(_ fileName: String) throws {
    do {
      guard let url = try getUrl(forKey: fileName) else { return }
      do {
        try FileManager.default.removeItem(at: url)
      } catch {
        throw error
      }
    } catch {
      throw error
    }
  }
  
  func singleValue<T>(forKey key: String, in fileName: String) throws -> T? {
    do {
      guard let json = try getJSONDictinary(fileName) else {return nil}
      guard let value = json[key] as? T else { return nil }
      
      return value
    } catch {
      throw error
    }
  }
  
  func arrayValue<T>(forKey key: String, in fileName: String) throws -> [T] {
    var arrayValue = [T]()
    do {
      guard let json =  try getJSONDictinary(fileName) else {return arrayValue}
      guard let value = json[key] as? [T] else { return arrayValue }
      
      arrayValue = value
    } catch {
      throw error
    }
    
    return arrayValue
  }
  
  func arrayValue(_ fileName: String) throws -> [[String: Any]] {
    var arrayValue = [[String: Any]]()
    do {
      guard let json =  try getJSONArray(fileName) as? [[String: Any]]  else { return arrayValue }
      
      arrayValue = json
    } catch {
      throw error
    }
    
    return arrayValue
  }
  
  func dictionaryValue(_ fileName: String) throws -> [String: Any] {
    var dictionaryValue = [String: Any]()
    
    do {
      guard let json = try getJSONDictinary(fileName) else {return dictionaryValue}
      
      dictionaryValue = json
    } catch {
      throw error
    }
    
    return dictionaryValue
  }
  
}
