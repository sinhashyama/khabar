//
//  DataViewController.swift
//  Khabar
//
//  Created by Singh, Abhay on 3/12/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import UIKit
import WebKit


class DataViewController: UIViewController, WKNavigationDelegate {

    //@IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    var urlString: String = ""
    var webView: WKWebView!
    
    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: urlString)!
        webView = WKWebView(frame: self.view.frame)
        let request = URLRequest(url: url)
        webView.navigationDelegate = self
        webView.load(request)
        self.view.addSubview(webView)
        self.view.sendSubview(toBack: webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.dataLabel!.text = dataObject
    }

     func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
     func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
        
        activityMonitor.startAnimating()
    }
     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        activityMonitor.stopAnimating()
        activityMonitor.hidesWhenStopped = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        if let HTTPResponse = navigationResponse.response as? HTTPURLResponse {
            let statusCode = HTTPResponse.statusCode
            if statusCode != 200 {
                print("Paper is not coming today`")
            }
        }
        decisionHandler(.allow)
    }
    
    
    @IBAction func gotoHome(_ sender: Any) {
        self.performSegue(withIdentifier: "showSettings", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSettings" {
            if let destiantionVC = segue.destination as? MasterViewController {
                //set papername , statename, cityname to instance of modalController(create init value with parameter) from rootViewController
                //self.splitViewController?.preferredDisplayMode = .primaryHidden
                //self.splitViewController?.presentsWithGesture = false
            }
        }
    }
}
