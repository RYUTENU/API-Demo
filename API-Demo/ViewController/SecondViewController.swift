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
    
    var needBackButton: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if needBackButton == true {
            setToolbar()
        }
    }
    
    func setToolbar() {
        
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.bounds.size.width, height:20)))
        
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(back))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([backButton, flexSpace], animated: false)
        toolbar.sizeToFit()
        
        // 問題1. Toolbar どうやってviewではなく、Safe Areaに付けるのか。
        webView.addSubview(toolbar)
        
        /*
        webView.transform = CGAffineTransform(translationX: 0, y: toolbar.frame.size.height)
        */
    }
    
    @objc func back() {
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let urlString = qiita?.url else { return }
        
        guard let qiitaUrl = URL(string: urlString) else { return }
        
        webView.load(URLRequest(url: qiitaUrl))
    }
}
