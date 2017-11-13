//
//  utilites.swift
//  khabar
//
//  Created by Singh, Abhay on 3/20/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import Foundation

final class utilities:NSObject {
    
    
    func loadJSON(filename:String) -> NSDictionary {
        let bundle = Bundle(for: object_getClass(self))
        let path = bundle.path(forResource: filename, ofType: "JSON")
        print(filename)
        var response = try? String(contentsOfFile:path!, encoding: String.Encoding.utf8)
        response = response?.replacingOccurrences(of: "\n", with: "", options: [])
        
        let responseData = response?.data(using: String.Encoding.utf8, allowLossyConversion: true)
        
        return (try! JSONSerialization.jsonObject(with: responseData!, options:[])) as! NSDictionary
    }
}
