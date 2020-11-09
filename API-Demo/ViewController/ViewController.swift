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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let qiita = qiitas[indexPath.row]
        
        guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as? SecondViewController else { return }
        
        secondVC.qiita = qiita
        
        if (indexPath.row % 2 == 0) {
            
            secondVC.needBackButton = false
            navigationController?.pushViewController(secondVC, animated: true)
            return
        }
        
        if (indexPath.row % 3 == 0) {
            
            secondVC.needBackButton = true
            secondVC.modalTransitionStyle = .coverVertical
            present(secondVC, animated: true, completion: nil)
            return
        }
        
        if (indexPath.row % 5 == 0) {
            
            guard let qiitaUrl = qiita.url else { return }
            
            let alert = UIAlertController(title: "下記のURLを開く", message: "\(qiitaUrl)", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default) { (action) in
                
                guard let url = URL(string: qiitaUrl) else { return }
                UIApplication.shared.open(url)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            
            present(alert, animated: true, completion: nil)
            return
        }
    }
}
