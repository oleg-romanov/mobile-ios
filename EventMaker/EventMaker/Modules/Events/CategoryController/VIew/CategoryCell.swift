//
//  CategoryView.swift
//  EventMaker
//
//  Created by Олег Романов on 26.04.2022.
//

import UIKit

class CategoryCell: UITableViewCell {
    var id: Int?
    var name: String?

    @IBOutlet var nameLabel: UILabel!

    func configure(category: Category) {
        id = category.id
        name = category.name
        nameLabel.text = name
    }

    func addCategoryConfigure() {
        nameLabel.text = "Добавить категорию"
    }
}
