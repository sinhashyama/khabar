//
//  ePaperLink.swift
//  khabar
//
//  Created by Singh, Abhay on 2/23/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import Foundation

final class ePaper:NSObject {
    
    struct CityAttributes {
        fileprivate(set) var nameCity           : String
        fileprivate(set) var cityCode           : String
        fileprivate(set) var isInPublication    : String
    }
    
    struct SuperCityAttributes {
        fileprivate(set) var superCityName  : String
        fileprivate(set) var SuperCityCode  : String
        fileprivate(set) var cities         : [CityAttributes]
    }
    
    
    struct StateAttributes {
        fileprivate(set) var stateName  : String
        fileprivate(set) var stateCode  : String
        fileprivate(set) var superCitySection : [SuperCityAttributes]
        func allCities() -> [CityAttributes] {
            var all = [CityAttributes]()
            for superCity in self.superCitySection {
                print("supercity \(superCity.superCityName)")
                for city in superCity.cities {
                    all.append(city)
                }
            }
            return all
        }
    }
    
    fileprivate(set) var stateCollection = [StateAttributes]()
    fileprivate(set) var nameEpaper:String?
    fileprivate(set) var initialURL:String?
    fileprivate(set) var MainEdition:String?
    fileprivate(set) var date = Date()
    var stateNameArray = [String]()
    var citiesArray = [String]()
    var citiesStateDic = [String:[String]]()
    
    init(epaperItem:Dictionary<String, AnyObject>){
        self.nameEpaper = epaperItem["name"] as? String
        self.initialURL = epaperItem["InitialURL"] as? String
        self.date = Date()
        self.MainEdition = epaperItem["MainEdition"] as? String
        super.init()
        self.stateCollection = self.setupStateDictionary(stateLocation: epaperItem["PublishLocation"] as! [String: AnyObject])
    }
    
    
    fileprivate func setupStateDictionary(stateLocation : [String: AnyObject]) -> [StateAttributes]  {
        var stateAttrArray = [StateAttributes]()
        var superCitiAttrArray = [SuperCityAttributes]()
        var cityAttrArray = [CityAttributes]()
        if let stateVar = stateLocation["state"] as? NSArray {
            for stateEnum in stateVar {
                if let state = stateEnum as? [String:AnyObject]{
                    let stateName = state["stateName"] as? String
                    stateNameArray.append(stateName!)
                    let stateCode = state["stateCode"] as? String
                    if let superCityCollect = state["superCity"] as? NSArray {
                        for superCityEnum in superCityCollect {
                            if let superCity = superCityEnum as? [String:AnyObject]{
                                let superCityName = superCity["name"] as? String
                                let superCityCode = superCity["superCityCode"] as? String
                                if let cityCollect = superCity["city"] as? NSArray {
                                    for cityEnum in cityCollect {
                                        if let city = cityEnum as? [String:AnyObject] {
                                            let cityName = city["cityName"] as? String
                                            citiesArray.append(cityName!)
                                            let cityCode = city["cityCode"] as? String
                                            let isInPublication = city["isInPublication"] as? String
                                            cityAttrArray.append(CityAttributes(nameCity:cityName!,cityCode:cityCode!,isInPublication: isInPublication!))
                                        }
                                    }
                                }
                                superCitiAttrArray.append(SuperCityAttributes(superCityName:superCityName!, SuperCityCode:superCityCode!,cities:cityAttrArray))
                            }
                        }
                        citiesStateDic[stateName!] = citiesArray
                        citiesArray = []
                        stateAttrArray.append(StateAttributes(stateName:stateName!, stateCode:stateCode!, superCitySection:superCitiAttrArray))
                    }
                }
            }
        }
        return stateAttrArray
    }
    
    func getSuperCityCodeUsingCity(city:String, superCityCollect:[SuperCityAttributes]) -> String {
        for supercity in superCityCollect {
            if  (supercity.cities.map{$0.nameCity}.contains(city)){
                return supercity.SuperCityCode
            }
        }
        return " "
    }
}
