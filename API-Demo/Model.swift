//
//  Model.swift
//  API-Demo
//
//  Created by Alan Liu on 2020/11/06.
//

import Foundation

class Model {
    
    static func getQiitas(completion: @escaping ([Qiita]) -> Void) {
        
        guard let url = URL(string: "https://qiita.com/api/v2/items") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            
            do {
                let qiitas = try JSONDecoder().decode([Qiita].self, from: data)
                
                completion(qiitas)
            }
            catch {
            }
        }
        dataTask.resume()
    }
}
