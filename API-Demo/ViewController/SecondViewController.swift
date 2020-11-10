//
//  SecondViewController.swift
//  API-Demo
//
//  Created by 劉 天宇 on 2020/11/06.
//

import UIKit
import WebKit

class SecondViewController: UIViewController {

    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var webView: WKWebView!
    
    var qiita: Qiita?
    
    var isNeedBackButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isNeedBackButton {
            toolbar.isHidden = false
        }
    }
    
    @IBAction func actionDismiss(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let urlString = qiita?.url, let qiitaUrl = URL(string: urlString) else { return }
        
        webView.load(URLRequest(url: qiitaUrl))
    }
}
