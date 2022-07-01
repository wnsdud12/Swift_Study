//
//  TableViewCell.swift
//  CRUD_CoreData
//
//  Created by 박준영 on 2022/07/01.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let id = "cell"

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var shortcutNumber: UILabel!
}
