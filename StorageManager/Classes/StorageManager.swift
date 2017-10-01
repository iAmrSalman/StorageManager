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
      return try getDataUrl(key)
    }
    
    return url
  }
  
  fileprivate func getDataUrl(_ key: String) throws -> URL? {
    let document = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let targetUrl = document.appendingPathComponent("\(key).json")
    UserDefaults.standard.set(targetUrl, forKey: key)
    
    return targetUrl
  }
  
  fileprivate func getJSONDictinary(_ key: String) throws -> [String: Any]? {
    guard let fileUrl = try getUrl(forKey: key) else { return nil }
    
    if let jsonData = try? Data(contentsOf: fileUrl) {
      let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
      
      return jsonResult
    } else {
      return nil
    }
  }
  
  fileprivate func getJSONArray(_ key: String) throws -> [Any]? {
    guard let fileUrl = try getUrl(forKey: key) else { return nil }
    
    if let jsonData = try? Data(contentsOf: fileUrl) {
      let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [Any]
      
      return jsonResult
    } else {
      return nil
    }
  }
  
  fileprivate func getJSONText(fromDictionary dictionary: [String: Any]) throws -> String? {
    let theJSONData = try
      JSONSerialization.data(withJSONObject: dictionary ,options: JSONSerialization.WritingOptions.prettyPrinted)
    let theJSONText = String(data: theJSONData, encoding: String.Encoding.utf8)
    return theJSONText
  }
  
  fileprivate func getJSONText(fromArray array: [Any]) throws -> String? {
    let theJSONData = try
      JSONSerialization.data(withJSONObject: array ,options: JSONSerialization.WritingOptions.prettyPrinted)
    let theJSONText = String(data: theJSONData, encoding: String.Encoding.utf8)
    return theJSONText
  }
  
  fileprivate func write(jsonText: String?, toUrl url: URL?) throws {
    guard let unwrappedURL = url else { throw SMError.invalid("URL", url) }
    try jsonText?.write(to: unwrappedURL , atomically: true, encoding: String.Encoding.utf8)
  }
  
  //MARK: - Actions
  
  func store(dictionary: [String: Any], in fileName: String) throws {
    try write(jsonText: try getJSONText(fromDictionary: dictionary), toUrl: try getUrl(forKey: fileName))
  }
  
  func store(array: [Any], in fileName: String) throws {
    try write(jsonText: try getJSONText(fromArray: array), toUrl: try getUrl(forKey: fileName))
  }
  
  func store(data: Data, jsonType: JSONType, in fileName: String) throws {
    switch jsonType {
    case .array:
      guard let array = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [Any] else { throw SMError.invalid(fileName, jsonType) }
      try write(jsonText: try getJSONText(fromArray: array), toUrl: try getUrl(forKey: fileName))
    case .dictionary:
      guard let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] else { throw SMError.invalid(fileName, jsonType) }
      try write(jsonText: try getJSONText(fromDictionary: dictionary), toUrl: try getUrl(forKey: fileName))
    }
  }
  
  func update<T>(vlaue: T, forKey key: String, `in` fileName: String) throws {
    var dictionary = try StorageManager.default.dictionaryValue(fileName)
    dictionary[key] = vlaue
    try StorageManager.default.store(dictionary: dictionary, in: fileName)
  }
  
  func clear(_ fileName: String) throws {
    guard let url = try getUrl(forKey: fileName) else { return }
    try FileManager.default.removeItem(at: url)
  }
  
  func singleValue<T>(forKey key: String, in fileName: String) throws -> T? {
    guard let json = try getJSONDictinary(fileName) else {return nil}
    guard let value = json[key] as? T else { return nil }
    
    return value
  }
  
  func arrayValue<T>(forKey key: String, in fileName: String) throws -> [T] {
    var arrayValue = [T]()
    guard let json =  try getJSONDictinary(fileName) else {return arrayValue}
    guard let value = json[key] as? [T] else { return arrayValue }
    
    arrayValue = value
    
    return arrayValue
  }
  
  func arrayValue(_ fileName: String) throws -> [[String: Any]] {
    var arrayValue = [[String: Any]]()
    guard let json =  try getJSONArray(fileName) as? [[String: Any]]  else { return arrayValue }
    
    arrayValue = json
    return arrayValue
  }
  
  func dictionaryValue(_ fileName: String) throws -> [String: Any] {
    var dictionaryValue = [String: Any]()
    
    guard let json = try getJSONDictinary(fileName) else {return dictionaryValue}
    
    dictionaryValue = json
    
    return dictionaryValue
  }
  
}