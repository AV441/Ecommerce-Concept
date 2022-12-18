//
//  Coordinator.swift
//  Ecommerce Concept
//
//  Created by Андрей on 12.12.2022.
//

import UIKit

protocol Coordinator {
    var navigationController : UINavigationController { get set }
    
    func start()
    func showFilters()
    func closeFilters()
    func showDetails()
    func backToHome()
    func showCart()
}

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeViewController()
        viewController.viewModel = HomeViewModel(coordinator: self,
                                                 networkManager: NetworkManager.shared)
        navigationController.viewControllers = [viewController]
    }
    
    func showFilters() {
        let viewModel = FiltersViewModel(coordinator: self)
        let viewController = FiltersViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .overFullScreen
        navigationController.present(viewController, animated: true)
    }
    
    func closeFilters() {
        navigationController.dismiss(animated: true)
    }
    
    func showDetails() {
        let viewController = DetailsViewController()
        viewController.viewModel = DetailsViewModel(coordinator: self,
                                                    networkManager: NetworkManager.shared)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func backToHome() {
        navigationController.popViewController(animated: true)
    }
    
    func showCart() {
        let networkManager = NetworkManager.shared
        let viewModel = CartViewModel(coordinator: self, networkManager: networkManager)
        let viewController = CartViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
