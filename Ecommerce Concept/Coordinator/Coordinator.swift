//
//  Coordinator.swift
//  Ecommerce Concept
//
//  Created by Андрей on 12.12.2022.
//

import UIKit

protocol Coordinator {
    func start()
    func showFilters()
    func showDetails()
    func showCart()
    func popViewController()
    func dismissViewController()
}

final class AppCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let networkManager = NetworkManager.shared
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self, networkManager: networkManager)
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
    
    func showFilters() {
        let viewModel = FiltersViewModel(coordinator: self)
        let viewController = FiltersViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .overFullScreen
        navigationController.present(viewController, animated: true)
    }
        
    func showDetails() {
        let viewModel = DetailsViewModel(coordinator: self, networkManager: networkManager)
        let viewController = DetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showCart() {
        let viewModel = CartViewModel(coordinator: self, networkManager: networkManager)
        let viewController = CartViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: true)
    }
    
}
