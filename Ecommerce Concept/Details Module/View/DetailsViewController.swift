//
//  DetailsViewController.swift
//  Ecommerce Concept
//
//  Created by Андрей on 12.12.2022.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    public var viewModel: DetailsViewModel!
    
    private var detailsView: DetailsView!
    
    var cartBarButtonItem = UIBarButtonItem()
    var cartButton = UIButton()
    var badgeCount: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.updateView = { [unowned self] in
            guard let details = self.viewModel.detailsData else { return }
            
            self.detailsView.titleLabel.text = details.title
            self.detailsView.likeButton.isSelected = details.isFavorites
            self.detailsView.ratingView.rating = details.rating
            self.detailsView.cpuLabel.text = details.cpu
            self.detailsView.cameraLabel.text = details.camera
            self.detailsView.sdLabel.text = details.sd
            self.detailsView.ssdLabel.text = details.ssd
            self.detailsView.priceLabel.text = "$" + details.price.formattedWithSeparator
           
            self.detailsView.collectionView.reloadData()
            
            self.detailsView.createColorButtons(colors: details.color)
            self.detailsView.createCapacityButtons(capacityOptions: details.capacity)
            self.detailsView.makeAddToCartHStack()
        }
        
        viewModel.updateCartBadge = { [unowned self] in
            self.badgeCount += 1
            self.showBadge(withCount: self.badgeCount)
        }
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(named: "Background")
        
        detailsView = DetailsView()
        detailsView.delegate = self
        detailsView.collectionView.dataSource = self

        view.addSubview(detailsView)
        
        detailsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Product details"
        navigationItem.setHidesBackButton(true, animated:false)
        
        let backBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(backToMain))
        
        navigationItem.leftBarButtonItem = backBarButtonItem
        
        cartButton.setBackgroundImage(UIImage(named: "cart"), for: .normal)
        
        cartBarButtonItem.customView = cartButton
        
        navigationItem.rightBarButtonItem = cartBarButtonItem
    }
    
    let badgeSize: CGFloat = 20
    let badgeTag = 9830384

    func badgeLabel(withCount count: Int) -> UILabel {
        let badge = UILabel(frame: CGRect(x: 0, y: 0, width: badgeSize, height: badgeSize))
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.tag = badgeTag
        badge.layer.cornerRadius = badge.bounds.size.height / 2
        badge.textAlignment = .center
        badge.layer.masksToBounds = true
        badge.textColor = .white
        badge.font = badge.font.withSize(12)
        badge.backgroundColor = .systemRed
        badge.text = String(count)
        return badge
    }
    
    private func removeBadge() {
//        if let badge = cartBarButtonItem.viewWithTag(badgeTag) {
//            badge.removeFromSuperview()
//        }
    }
    
    private func showBadge(withCount count: Int) {
        let badge = badgeLabel(withCount: count)
        cartButton.addSubview(badge)

        NSLayoutConstraint.activate([
            badge.centerXAnchor.constraint(equalTo: cartButton.centerXAnchor, constant: 12),
            badge.centerYAnchor.constraint(equalTo: cartButton.centerYAnchor, constant: -12),
            badge.widthAnchor.constraint(equalToConstant: badgeSize),
            badge.heightAnchor.constraint(equalToConstant: badgeSize)
        ])
    }
    
    @objc
    private func backToMain() {
        viewModel.coordinator.backToHome()
    }
    
    @objc
    private func goToCart() {
//        viewModel.coordinator.showCart()
    }
    
}

extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.detailsData?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCollectionViewCell.id, for: indexPath) as! DetailsCollectionViewCell
        if let imageAddress = viewModel.detailsData?.images[indexPath.item] {
            cell.configure(with: imageAddress)
        } 
        return cell
        
    }

}

extension DetailsViewController: DetailViewDelegate {
    
    func didTapAddToCartButton() {
        viewModel.addToCart(item: viewModel.detailsData)
    }
    
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
