//
//  SecondViewController.swift
//  API-Demo
//
//  Created by 劉 天宇 on 2020/11/06.
//

import UIKit
import WebKit

class SecondViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var qiita: Qiita?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let urlString = qiita?.url else { return }
        
        guard let qiitaUrl = URL(string: urlString) else { return }
    }
}
