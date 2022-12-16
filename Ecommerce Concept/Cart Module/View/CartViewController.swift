//
//  CartViewController.swift
//  Ecommerce Concept
//
//  Created by Андрей on 16.12.2022.
//

import UIKit

final class CartViewController: UIViewController {
    
    public var viewModel: CartViewModel!
    private var cartView: CartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        bindViewModel()
    }
    
    private func configureNavigationBar() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"),
                                                 style: .plain,
                                                 target: self,
                                                action: #selector(didTapBackButton))
        
        let rightBarButtonItemWithIcon = UIBarButtonItem(image: UIImage(named: "icAddress"),
                                                 style: .plain,
                                                 target: self,
                                                 action: nil)
        
        let rightBarButtonItemWithLabel = UIBarButtonItem(title: "Add address",
                                                 style: .plain,
                                                 target: self,
                                                 action: nil)
        rightBarButtonItemWithLabel.tintColor = .black
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItems = [rightBarButtonItemWithIcon, rightBarButtonItemWithLabel]
    }
    
    @objc
    private func didTapBackButton() {
        viewModel.coordinator.backToHome()
    }
    
    private func configureView() {
        cartView = CartView(frame: view.bounds)
        cartView.tableView.dataSource = self
        cartView.tableView.delegate = self
        view.addSubview(cartView)
    }
    
    private func bindViewModel() {
        viewModel.updateView = { [unowned self] in
            
            cartView.tableView.reloadData()
            
            if let item = viewModel.cartItem {
                cartView.totalPriceLabel.text = "$\(viewModel.totalPrice.formattedWithSeparator) us"
                cartView.deliveryPriceLabel.text = item.delivery
            }
        }
    }
    
}

// UITableViewDataSource
extension CartViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.basket.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.id, for: indexPath) as! CartCell
        if !viewModel.basket.isEmpty {
            let item = viewModel.basket[indexPath.section]
            cell.configure(with: item)
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        return UIView()
    }
   
}

// UITableViewDelegate
extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return view.height*0.05
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height*0.09
        
    }

}

// CartCellDelegate
extension CartViewController: CartCellDelegate {
    
    func plusButtonTapped(onItem item: BasketItem) {
        viewModel.addOneItem(withID: item.id)
    }
    
    func minusButtonTapped(onItem item: BasketItem) {
        viewModel.removeOneItem(withID: item.id)
    }
    
    func trashButtonTapped(onItem item: BasketItem) {
        viewModel.deleteAllItems(withID: item.id)
    }
    
}
