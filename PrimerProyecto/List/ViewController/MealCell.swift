//
//  MealCell.swift
//  PrimerProyecto
//
//  Created by Diego Luna on 8/19/23.
//

import Foundation
import UIKit

class MealCell: UITableViewCell {
    
    @IBOutlet private weak var mealNameLabel: UILabel!
    @IBOutlet private weak var mealImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mealImageView.image = nil
    }
    
    func setup(meal: Meal) {
        mealNameLabel.text = meal.name
    }
    
    func setupImage(image: UIImage?) {
        DispatchQueue.main.async { [weak mealImageView] in
            mealImageView?.image = image ?? UIImage(named: "food_plate")
        }
    }
}
