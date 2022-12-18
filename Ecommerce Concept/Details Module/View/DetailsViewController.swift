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
    
    let cartButton = UIButton(image: UIImage(named: "cart"))
    
    var badgeCount: Int = 0
    lazy var badge = badgeLabel(withCount: 0)
    let badgeSize: CGFloat = 20
    let badgeTag = 9830384
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        bindViewModel()
        NotificationCenter.default.addObserver(self, selector: #selector(removeBadge), name: NSNotification.Name(rawValue: "clearCart"), object: nil)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Product details"
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(didTapBackButton))
        
        let rightBarButtonItem = UIBarButtonItem(image: nil,
                                                 style: .plain,
                                                 target: self,
                                                 action: nil)
        rightBarButtonItem.customView = cartButton
        cartButton.addTarget(self, action: #selector(didTapCartButton), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
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
    
    private func bindViewModel() {
        viewModel.updateView = { [unowned self] in
            guard let details = self.viewModel.detailsData else { return }
            
            detailsView.titleLabel.text = details.title
            detailsView.likeButton.isSelected = details.isFavorites
            detailsView.ratingView.rating = details.rating
            detailsView.cpuLabel.text = details.cpu
            detailsView.cameraLabel.text = details.camera
            detailsView.sdLabel.text = details.sd
            detailsView.ssdLabel.text = details.ssd
            detailsView.priceLabel.text = "$" + details.price.formattedWithSeparator
           
            detailsView.collectionView.reloadData()
            
            detailsView.createColorButtons(colors: details.color)
            detailsView.createCapacityButtons(capacityOptions: details.capacity)
        }
        
        viewModel.updateCartBadge = { [unowned self] in
            badgeCount += 1
            badge.text = badgeCount.description
            badge.isHidden = false
        }
    }
    
    func badgeLabel(withCount count: Int) -> UILabel {
        let badge = UILabel(frame: CGRect(x: 0, y: 0, width: badgeSize, height: badgeSize))
        badge.tag = badgeTag
        badge.layer.cornerRadius = badge.bounds.size.height / 2
        badge.textAlignment = .center
        badge.layer.masksToBounds = true
        badge.textColor = .white
        badge.font = badge.font.withSize(12)
        badge.backgroundColor = .systemRed
        badge.text = String(count)
        badge.isHidden = true
        
        cartButton.addSubview(badge)

        badge.snp.makeConstraints { make in
            make.centerX.equalTo(cartButton.snp.centerX).offset(12)
            make.centerY.equalTo(cartButton.snp.centerY).offset(-12)
            make.width.equalTo(badgeSize)
            make.height.equalTo(badgeSize)
        }
        return badge
    }
    
    @objc
    private func removeBadge() {
        badgeCount = 0
        badge.text = badgeCount.description
        badge.isHidden = true
    }
    
    @objc
    private func didTapBackButton() {
        viewModel.coordinator.backToHome()
    }
    
    @objc
    private func didTapCartButton() {
        viewModel.coordinator.showCart()
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
