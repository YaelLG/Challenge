//
//  DetailMealViewController.swift
//  PrimerProyecto
//
//  Created by Diego Luna on 8/19/23.
//

import Foundation
import UIKit

class DetailMealViewController: UIViewController {
    
    @IBOutlet private weak var nameMealLabel: UILabel!
    @IBOutlet private weak var ingredientsLabel: UILabel!
    @IBOutlet private weak var instructionsTextView: UITextView!
    
    var identifierMeal: String?
    private var viewModel: DetailMealViewModelProtocol = DetailMealViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
        viewModel.updateUI = {
            DispatchQueue.main.async { [weak self] in
                self?.nameMealLabel.text = self?.viewModel.meal?.name
                self?.ingredientsLabel.text = self?.viewModel.meal?.ingredientsPresentation
                self?.instructionsTextView.text = self?.viewModel.meal?.instructions
            }
        }
    }
    
    func requestData() {
        guard let identifierMeal = identifierMeal else {
            navigationController?.popViewController(animated: true)
            return
        }
        viewModel.loadData(identifier: identifierMeal)
    }
}
