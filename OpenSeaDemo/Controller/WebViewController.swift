//
//  WebViewController.swift
//  OpenSeaDemo
//
//  Created by Funday on 2020/4/22.
//  Copyright © 2020 Edison. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var url: String?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = url, let webURL = URL(string: url) {
            webView.load(URLRequest(url: webURL))
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
