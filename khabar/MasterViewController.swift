//
//  MasterViewController.swift
//  khabar
//
//  Created by Singh, Abhay on 3/13/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import UIKit


class MasterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var PaperName: UIButton!
    @IBOutlet weak var StateName: UIButton!
    @IBOutlet weak var CityName: UIButton!
    
    var epaper = epaperLink()
    var indexNumber:Int?
    var dataArray:[String] = [] {
        didSet {
            dataSelector.reloadAllComponents()
        }
    }
    var selectedButton = 0
    var rowCount:Int = 0 {
        didSet {
            if selectedButton == 1 {
                PaperName.setTitle(dataArray[rowCount], for: .normal)
                userselect.setEpaper(epaper: dataArray[rowCount])
            } else if selectedButton == 2 {
                StateName.setTitle(dataArray[rowCount], for: .normal)
                userselect.setState(state: dataArray[rowCount])
            } else if selectedButton == 3 {
                CityName.setTitle(dataArray[rowCount], for: .normal)
                userselect.setCity(city: dataArray[rowCount])
            }
        }
    }
    
    
    @IBOutlet weak var dataSelector: UIPickerView!

    let userselect = userSelection.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = epaper.getPaperName()
        PaperName.setTitle(userselect.getEpaper, for: .normal)
        StateName.setTitle(userselect.getState, for: .normal)
        CityName.setTitle(userselect.getCity, for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSelector.isHidden = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rowCount = row
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return dataArray[row]//[row]
    }
    
    
    @IBAction func paperNameSelect(_ sender: Any) {
        dataSelector.isHidden = false
        dataArray = epaper.getPaperName()
        selectedButton = 1
    }
    
    @IBAction func stateNameSelect(_ sender: Any) {
        dataSelector.isHidden = false
        dataArray = (userSelection.epaper?.stateNameArray)!
        selectedButton = 2
    }
    
    @IBAction func cityNameSelect(_ sender: Any) {
        dataSelector.isHidden = false
        dataArray = (userSelection.epaper?.citiesStateDic[userselect.getState])!
        selectedButton = 3
    }
    
    @IBAction func goSelect(_ sender: Any) {
        dataSelector.isHidden = true
        self.performSegue(withIdentifier: "showEpaper", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEpaper" {
            if let destiantionVC = segue.destination as? RootViewController {
                //set papername , statename, cityname to instance of modalController(create init value with parameter) from rootViewController
                //self.splitViewController?.preferredDisplayMode = .primaryHidden
                //self.splitViewController?.presentsWithGesture = false
                destiantionVC.preVC = self
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

