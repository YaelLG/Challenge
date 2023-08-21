//
//  MealsListViewModel.swift
//  PrimerProyecto
//
//  Created by Diego Luna on 8/19/23.
//

import Foundation

protocol MealsListViewModelProtocol: AnyObject {
    var mealsList: [Meal] { get}
    var updateUI: (() -> (Void))? { get set }
    func loadData()
}

extension MealsListViewModel: MealsListViewModelProtocol {
    var mealsList: [Meal] {
        meals
    }
}

class MealsListViewModel {
    struct Constants {
        static let dessertMealTypeName = "Dessert"
    }
    
    var updateUI: (() -> (Void))?
    private var meals: [Meal] = []
    
    func loadData() {
        fetchMealsFilterByDessert(model: MealsResponse.self, completion: { [weak self] in
            guard let self = self, !self.meals.isEmpty else { return }
            self.updateUI?()
        })
    }
    
    private func fetchMealsFilterByDessert(model: Decodable.Type, completion: @escaping () -> Void) {
        let endPoint = ServiceDefinitions.urlDessertList(mealType: Constants.dessertMealTypeName)
        Request.makeRequest(endPoint: endPoint,
                            method: .get,
                            model: model,
                            onSuccess: { [weak self] response in
            guard let mealResponse = response as? MealsResponse else { return }
            self?.meals = mealResponse.meals.sorted { $0.name < $1.name }.compactMap{ $0 }
            completion()
        })
    }
}
