//
//  ViewController.swift
//  API-Demo
//
//  Created by 劉 天宇 on 2020/11/05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var qiitas: [Qiita] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // tableViewCell Identifier
        tableView.register(UINib(nibName: "qiitaCell", bundle: nil), forCellReuseIdentifier: "qiitaCell")
        
        Model.getQiitas { (qiitas) in
            self.qiitas = qiitas
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        qiitas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "qiitaCell", for: indexPath) as? qiitaCell else {
            
            return UITableViewCell(style: .default, reuseIdentifier: "qiitaCell")
        }
        
        let qiita = qiitas[indexPath.row]
        
        cell.setCell(qiita)
        
        return cell
    }
}
