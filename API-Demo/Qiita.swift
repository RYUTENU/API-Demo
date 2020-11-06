//
//  Qiita.swift
//  API-Demo
//
//  Created by 劉 天宇 on 2020/11/05.
//

import Foundation

struct Qiita: Codable {
    
    var title: String?
    var user: User?
    
    struct User: Codable {
        var name: String?
    }
}
