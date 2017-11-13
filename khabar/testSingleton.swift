//
//  testSingleton.swift
//  khabar
//
//  Created by Singh, Abhay on 5/12/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import Foundation

public class SessionState {
    
    
    private var storage = [String:Any]()
    
    private init() {}
    
    public static let shared: SessionState = {
        let instance = SessionState()
        return instance
    }()
    
    public func set( _ value: Any, forkey key: String){
        storage[key] = value
    }
    
    public func object( forKey key: String ) -> Any? {
        return storage[key] ?? nil
    }
    
}
