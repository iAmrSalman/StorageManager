//
//  StorageManager.swift
//  StorageManager
//
//  Created by Amr Salman on 1/26/18.
//  Copyright © 2018 StorageManager. All rights reserved.
//

import Foundation

public enum JSONType {
    case array
    case dictionary
}

open class StorageManager {
    
    public static let `default` = StorageManager()
    
    //MARK: - Helpers
    
    fileprivate func getUrl(forKey key: String) throws -> URL? {
        guard let url = try getDataUrl(key) else {
            return nil
        }
        
        return url
    }
    
    fileprivate func getDataUrl(_ key: String) throws -> URL? {
        let document = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let targetUrl = document.appendingPathComponent("\(key).json")
        if FileManager.default.fileExists(atPath: targetUrl.path) {
            return targetUrl
        } else {
            if FileManager.default.createFile(atPath: targetUrl.path, contents: nil, attributes: nil) {
                return targetUrl
            }
            return nil
        }
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
    
    //MARK: - CREATE
    
    public func store(dictionary: [String: Any], in fileName: String) throws {
        try write(jsonText: try getJSONText(fromDictionary: dictionary), toUrl: try getUrl(forKey: fileName))
    }
    
    public func store(array: [Any], in fileName: String) throws {
        try write(jsonText: try getJSONText(fromArray: array), toUrl: try getUrl(forKey: fileName))
    }
    
    public func store(data: Data, type: JSONType, in fileName: String) throws {
        switch type {
        case .array:
            guard let array = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [Any] else { throw SMError.invalid(fileName, type) }
            try write(jsonText: try getJSONText(fromArray: array), toUrl: try getUrl(forKey: fileName))
        case .dictionary:
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] else { throw SMError.invalid(fileName, type) }
            try write(jsonText: try getJSONText(fromDictionary: dictionary), toUrl: try getUrl(forKey: fileName))
        }
    }
    
    public func store<T: Hashable>(singleValue: T, in fileName: String)  throws {
        try store(dictionary: [fileName: singleValue], in: fileName)
    }
    
    //MARK: - UPDATE
    
    public func update<T: Hashable>(vlaue: T, forKey key: String, `in` fileName: String) throws {
        var dictionary = try StorageManager.default.dictionaryValue(fileName)
        dictionary[key] = vlaue
        try StorageManager.default.store(dictionary: dictionary, in: fileName)
    }
    
    public func append<T: Hashable>(_ element: T, `in` fileName: String) throws {
        var localArray: [T] = try arrayValue(fileName)
        localArray.append(element)
        try store(array: localArray, in: fileName)
    }
    
    public func remove<T: Hashable>(_ element: T, from fileName: String) throws {
        var localArray: [T] = try arrayValue(fileName)
        if let index = localArray.firstIndex(of: element) {
            localArray.remove(at: index)
            try store(array: localArray, in: fileName)
        }
    }
    
    //MARK: - DELETE
    
    public func clear(_ fileName: String) throws {
        guard let url = try getUrl(forKey: fileName) else { return }
        try FileManager.default.removeItem(at: url)
    }
    
    //MARK: - READ
    
    public func singleValue<T>(name fileName: String) throws -> T? {
        guard let localDictionary = try getJSONDictinary(fileName) else {return nil}
        guard let value = localDictionary[fileName] as? T else { return nil }
        
        return value
    }
    
    public func singleValue<T>(forKey key: String, in fileName: String) throws -> T? {
        guard let localDictionary = try getJSONDictinary(fileName) else {return nil}
        guard let value = localDictionary[key] as? T else { return nil }
        
        return value
    }
    
    public func arrayValue<T: Hashable>(forKey key: String, in fileName: String) throws -> [T] {
        guard let localDictionary =  try getJSONDictinary(fileName) else {return []}
        guard let value = localDictionary[key] as? [T] else { return [] }
        
        return value
    }
    
    public func arrayValue(in fileName: String) throws -> [[String: Any]] {
        guard let localArray =  try getJSONArray(fileName) as? [[String: Any]]  else { return [] }
        
        return localArray
    }
    
    public func arrayValue<T: Hashable>(_ fileName: String) throws -> [T] {
        guard let localArray =  try getJSONArray(fileName) as? [T]  else { return [] }
        
        return localArray
    }

    public func dictionaryValue(_ fileName: String) throws -> [String: Any] {
        guard let localDictionary = try getJSONDictinary(fileName) else {return [:]}
        
        return localDictionary
    }
    
}
