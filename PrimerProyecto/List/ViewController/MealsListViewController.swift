//
//  ViewController.swift
//  PrimerProyecto
//
//  Created by Diego Luna on 5/9/23.
//

import UIKit

class MealsListViewController: UIViewController {
    
    struct Constants {
        static let identifierCell = "MealCell"
        static let identifierViewController = "DetailMealViewController"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    private var viewModel: MealsListViewModelProtocol = MealsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        requestData()
        viewModel.updateUI = {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
    private func configUI() {
        tableView.alwaysBounceVertical = true
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func requestData() {
        refreshControl.beginRefreshing()
        viewModel.loadData()
    }
    
    @objc
    func refresh(_ sender: Any) {
        viewModel.loadData()
    }
}

extension MealsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mealsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifierCell) as? MealCell else {
            return UITableViewCell()
        }
        let meal = viewModel.mealsList[indexPath.row]
        cell.selectionStyle = .none
        cell.setup(meal: meal)
        downloadImageWith(url: meal.imageURL, completion: { [weak cell] image in
            cell?.setupImage(image: image)
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = viewModel.mealsList[indexPath.row]
        let storyboard = UIStoryboard(name: Constants.identifierViewController, bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? DetailMealViewController else { return }
        viewController.identifierMeal = meal.identifier
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func downloadImageWith(url: String, completion: @escaping (UIImage?) -> (Void)) {
        Cache.shared.searchImageWithUrl(url: url, cache: true) { image in
            completion(image)
        }
    }
}

