//
//  IntroductionViewController.swift
//  khabar
//
//  Created by Singh, Abhay on 3/19/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var yourName: UITextField!
    @IBOutlet weak var yourEmail: UITextField!
    @IBOutlet weak var yourPassword: UITextField!
    @IBOutlet weak var selectNewsPaper: UITextField!
    @IBOutlet weak var selectState: UITextField!
    @IBOutlet weak var selectCity: UITextField!
    @IBOutlet weak var dataSelector: UIPickerView!
    
    var epaper = epaperLink()
    let userselect = userSelection.sharedInstance
    
    var dataArray:[String] = [] {
        didSet {
            dataSelector.reloadAllComponents()
        }
    }
    var selectedButton = 0
    var rowCount:Int = 0 {
        didSet {
            if selectedButton == 1 {
                userselect.setEpaper(epaper: dataArray[rowCount])
            } else if selectedButton == 2 {
                userselect.setState(state: dataArray[rowCount])
            } else if selectedButton == 3 {
                userselect.setCity(city: dataArray[rowCount])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataArray = epaper.getPaperName()
        
    }

    
    //Editing did end
    @IBAction func yourNameBox(_ sender: Any) {
    }
    
    @IBAction func yourEmailBox(_ sender: Any) {
    }
    
    @IBAction func yourPasswordBox(_ sender: Any) {
    }
    
    @IBAction func selectNewsPaperbox(_ sender: Any) {
        dataSelector.isHidden = false
        dataArray = epaper.getPaperName()
        selectedButton = 1
    }
    
    @IBAction func selectPrefferedStateBox(_ sender: Any) {
        dataSelector.isHidden = false
        dataArray = (userSelection.epaper?.stateNameArray)!
        selectedButton = 2
    }
    
    @IBAction func selectPrefferedCityBox(_ sender: Any) {
        dataSelector.isHidden = false
        dataArray = (userSelection.epaper?.citiesStateDic[userselect.getState])!
        selectedButton = 3
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
        
        return dataArray[row]
    }
    
    @IBAction func submitButton(_ sender: Any) {
        if yourName.text != nil && yourEmail.text != nil && yourPassword.text != nil && selectNewsPaper.text != nil && selectState.text != nil && selectCity.text != nil {
            var userSelectArray = [""]
            let ePaperName = selectNewsPaper.text
            userSelectArray.append(ePaperName!)
            let state = selectState.text
            userSelectArray.append(state!)
            let city = selectCity.text
            userSelectArray.append(city!)
            UserDefaults.standard.set(userSelectArray, forKey: "userSelect")
            UserDefaults.standard.set(true, forKey: "hasBeenLaunchedBeforeFlag")
            UserDefaults.standard.synchronize()
        }
        dismiss(animated: true, completion: nil)
    }

}
