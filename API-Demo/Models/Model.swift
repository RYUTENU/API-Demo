//
//  Model.swift
//  API-Demo
//
//  Created by Alan Liu on 2020/11/06.
//

import Foundation

class Model {
    
    static func getQiitas(completion: @escaping ([Qiita]) -> Void) {
        
        guard let qiitaUrl = URL(string: "https://qiita.com/api/v2/items?per_page=50") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: qiitaUrl) { data, response, error in
            
            guard let data = data, error == nil else { return }
            
            do {
                let qiitas = try JSONDecoder().decode([Qiita].self, from: data)
                
                let qiitasFilter = qiitas.filter({$0.user?.name != ""})
                
                completion(qiitasFilter)
            }
            catch {
            }
        }
        dataTask.resume()
    }
}
