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
        tableView.register(UINib(nibName: "evenCell", bundle: nil), forCellReuseIdentifier: "evenCell")
        tableView.register(UINib(nibName: "oddCell", bundle: nil), forCellReuseIdentifier: "oddCell")
        
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
        
        let qiita = qiitas[indexPath.row]
        
        switch (indexPath.row % 2) {
        
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "evenCell", for: indexPath) as? evenCell else {
                return UITableViewCell(style: .default, reuseIdentifier: "error")
            }
            cell.setCell(qiita)
            return cell
        
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "oddCell", for: indexPath) as? oddCell else {
                return UITableViewCell(style: .default, reuseIdentifier: "error")
            }
            cell.setCell(qiita)
            return cell
        }
    }
}
