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
        
        tableView.dataSource = self
        tableView.delegate = self
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    // MARK: Private Methods
    /// Show Alert
    private func showAlert(urlStr: String?) {
        
        guard let qiitaUrl = urlStr else { return }
        let alert = UIAlertController(title: "下記のURLを開く", message: "\(qiitaUrl)", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            guard let url = URL(string: qiitaUrl) else { return }
            UIApplication.shared.open(url)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
            if let indexPathForSelectedRow = self.tableView.indexPathForSelectedRow {
                self.tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qiitas.count
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

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let qiita = qiitas[indexPath.row]
        
        guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as? SecondViewController else { return }
        
        secondVC.qiita = qiita
        
        if (indexPath.row % 2 == 0) {
            
            navigationController?.pushViewController(secondVC, animated: true)
            
        } else if (indexPath.row % 3 == 0) {
            
            secondVC.isNeedBackButton = true
            secondVC.modalTransitionStyle = .coverVertical
            present(secondVC, animated: true)
            
        } else if (indexPath.row % 5 == 0) {
            
            showAlert(urlStr: qiita.url)
            
        } else {
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
