//
//  userSelection.swift
//  khabar
//
//  Created by Singh, Abhay on 3/14/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import Foundation

final class userSelection: NSObject {
    static var epaper:ePaper?
    fileprivate(set) var epaperName : String?{
        didSet {
            if let epaperModel = utilities().loadJSON(filename: epaperName!) as? [String:AnyObject] {
               userSelection.epaper = ePaper(epaperItem: epaperModel["Epaper"] as! Dictionary<String, AnyObject>)
            }
        }
    }
    fileprivate(set) var stateName : String?
    fileprivate(set) var cityName : String?
    
    private init(epaper:String, state:String, city:String) {
        self.epaperName = epaper
        self.stateName = state
        self.cityName = city
        if let epaperModel = utilities().loadJSON(filename: epaperName!) as? [String:AnyObject] {
            userSelection.epaper = ePaper(epaperItem: epaperModel["Epaper"] as! Dictionary<String, AnyObject>)
        }
    }
    
    static let sharedInstance: userSelection = {
        if let selectArray = UserDefaults.standard.array(forKey: "userSelect") as? [String]{
            let epaper_name = selectArray[1]
            let state_name = selectArray[2]
            let city_name = selectArray[3]
            let instance = userSelection(epaper: epaper_name , state: state_name , city: city_name )
            return instance
        }
        return userSelection(epaper: "", state: "", city: "") // change to something default if it fails incase from userdefault
    }()
    
    
    
    var getEpaper:String {
        get {
            return epaperName!
        }
        set {
            self.epaperName = newValue
        }
    }
    
    func setEpaper(epaper:String){
        self.epaperName = epaper
    }
    
    var getState:String {
        get {
            return stateName!
        }
        set {
            self.stateName = newValue
        }
    }
    
    func setState(state:String){
        self.stateName = state
    }
    
    var getCity:String {
        get {
            return cityName!
        }
        set {
            self.cityName = newValue
        }
    }
    
    func setCity(city:String){
        self.cityName = city
    }
    
}
