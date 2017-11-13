//
//  epaperLink.swift
//  khabar
//
//  Created by Singh, Abhay on 3/3/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import Foundation



struct epaperLink{
    
    enum PaperName:String {
        case DanikJagran = "DanikJagran"
        case DanikBhaskar = "DanikBhaskar"
    }
    
    
    fileprivate var paperNameArray = ["DanikJagran", "DanikBhaskar"]
    
    func getEpaperLink(epaperName : String, stateName : String, cityName : String ) -> String {
        var link:String?
        let todayDate = Date()
        let myFormatter = DateFormatter()
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(abbreviation: "IST")!
        myFormatter.timeZone = TimeZone(abbreviation: "IST")
        if let epaperModel = utilities().loadJSON(filename: epaperName) as? [String:AnyObject] {
            let epaperSelected = ePaper(epaperItem: epaperModel["Epaper"] as! Dictionary<String, AnyObject>)
            let initialLink = epaperSelected.initialURL
            var superCityCode = " "
            var cityCode = " "
            for state in epaperSelected.stateCollection {
                if state.stateName == stateName {
                    superCityCode = epaperSelected.getSuperCityCodeUsingCity(city: cityName, superCityCollect: state.superCitySection)
                    for city in state.allCities(){
                        if cityName == city.nameCity {
                            cityCode = city.cityCode
                        }
                    }
                }
            }
            if epaperName == "DanikJagran" {
                myFormatter.dateFormat = "ddMMyyyy"
                let todayDateInFormat = myFormatter.string(from: todayDate)
                let day = calendar.component(.day, from: todayDate.dayBefore)
                print(day)
                let zeroadd = day < 10 ? "0" : ""
                link = "\(initialLink!)\(todayDateInFormat)/\(superCityCode)/\(zeroadd)\(day)\(cityCode)-pg-number-0.pdf"
            } else if epaperName == "DanikBhaskar" {
                myFormatter.dateFormat = "ddMMyyyy"
                let todayDateInFormat = myFormatter.string(from: todayDate)
                let day = calendar.component(.day, from: todayDate.dayBefore)
                let zeroadd = day < 10 ? "0" : ""
                link = "\(initialLink!)\(todayDateInFormat)/\(zeroadd)\(day)\(cityCode)-pg-number-0.PDF"
            }
        }

        return link!
    }
    
    
    func getPaperName() -> [String] {
        return paperNameArray
    }
    
    func getStateAndCitiesArray(filename: String) -> ([String],[String:[String]]){
        var stateCityTuple: ([String],[String:[String]])?
        if let epaperModel = utilities().loadJSON(filename: filename) as? [String:AnyObject] {
            let epaperObject = ePaper(epaperItem: epaperModel["Epaper"] as! Dictionary<String, AnyObject>)
            stateCityTuple = (epaperObject.citiesArray, epaperObject.citiesStateDic)
        }
        return stateCityTuple!
    }
    
}


