//
//  DetailMealViewModel.swift
//  PrimerProyecto
//
//  Created by Diego Luna on 8/19/23.
//

import Foundation

protocol DetailMealViewModelProtocol {
    var meal: DetailMeal? { get}
    var updateUI: (() -> (Void))? { get set }
    func loadData(identifier: String)
}

extension DetailMealViewModel: DetailMealViewModelProtocol {
    var meal: DetailMeal? {
        mealDetail
    }
}

class DetailMealViewModel {

    var updateUI: (() -> (Void))?
    private var mealDetail: DetailMeal?
    
    func loadData(identifier: String) {
        fetchMealDetailFilterById(identifier: identifier, model: DetailMealResponse.self, completion: { [weak self] in
            guard let self = self else { return }
            self.updateUI?()
        })
    }
    
    private func fetchMealDetailFilterById(identifier: String, model: Decodable.Type, completion: @escaping () -> Void) {
        let endPoint = ServiceDefinitions.urlGetMealDetail(identifier: identifier)
        Request.makeRequest(endPoint: endPoint,
                            method: .get,
                            model: model,
                            onSuccess: { [weak self] response in
            guard let mealResponse = response as? DetailMealResponse else { return }
            self?.mealDetail = mealResponse.meal
            completion()
        })
    }
}
