//
//  evenCell.swift
//  API-Demo
//
//  Created by 劉 天宇 on 2020/11/06.
//

import UIKit

class evenCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(_ qiita:Qiita) {
        
        titleLabel.text = qiita.title
        nameLabel.text = qiita.user?.name
    }
}
