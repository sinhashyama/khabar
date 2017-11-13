//
//  IntroductionViewController.swift
//  khabar
//
//  Created by Singh, Abhay on 3/19/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {
    
    @IBOutlet weak var yourName: UITextField!
    @IBOutlet weak var yourEmail: UITextField!
    @IBOutlet weak var yourPassword: UITextField!
    @IBOutlet weak var selectNewsPaper: UITextField!
    @IBOutlet weak var selectState: UITextField!
    @IBOutlet weak var selectCity: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Editing did end
    @IBAction func yourNameBox(_ sender: Any) {
    }
    
    @IBAction func yourEmailBox(_ sender: Any) {
    }
    
    @IBAction func yourPasswordBox(_ sender: Any) {
    }
    
    @IBAction func selectNewsPaperbox(_ sender: Any) {
    }
    
    @IBAction func selectPrefferedStateBox(_ sender: Any) {
    }
    
    @IBAction func selectPrefferedCityBox(_ sender: Any) {
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
