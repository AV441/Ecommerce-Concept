//
//  DetailsViewController.swift
//  Ecommerce Concept
//
//  Created by Андрей on 12.12.2022.
//

import UIKit

final class DetailsViewController: UIViewController {
    private var viewModel: DetailsViewModelProtocol
    private var detailsView: DetailsView!
    
    private lazy var badge = makeBadgeLabel()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton(image: UIImage(named: "cart"))
        button.addTarget(self, action: #selector(didTapCartButton), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        bindViewModel()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Product details"
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(didTapBackButton))
        
        let rightBarButtonItem = UIBarButtonItem()
        rightBarButtonItem.customView = cartButton
        
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
            
            self.detailsView.titleLabel.text = details.title
            self.detailsView.likeButton.isSelected = details.isFavorites
            self.detailsView.ratingView.rating = details.rating
            self.detailsView.cpuLabel.text = details.cpu
            self.detailsView.cameraLabel.text = details.camera
            self.detailsView.sdLabel.text = details.sd
            self.detailsView.ssdLabel.text = details.ssd
            self.detailsView.priceLabel.text = "$" + details.price.formattedWithSeparator
            
            self.detailsView.createColorButtons(colors: details.color)
            self.detailsView.createCapacityButtons(capacityOptions: details.capacity)
           
            self.detailsView.collectionView.reloadData()
        }
        
        viewModel.selectedColor.bind { [unowned self] color in
            for button in detailsView.colorButtons {
                if button.tag == viewModel.detailsData?.color.firstIndex(of: color) {
                    button.isSelected = true
                } else {
                    button.isSelected = false
                }
            }
        }
        
        viewModel.selectedCapacity.bind { [unowned self] capacity in
            for button in detailsView.capacityButtons {
                if button.tag == viewModel.detailsData?.capacity.firstIndex(of: capacity) {
                    button.isSelected = true
                } else {
                    button.isSelected = false
                }
            }
        }
        
        viewModel.selectedSection.bind { [unowned self] section in
            for button in detailsView.sectionButtons {
                if button.tag == DetailsSection.allCases.firstIndex(of: section) {
                    button.setSelected()
                } else {
                    button.setNormal()
                }
            }
        }
        
        viewModel.isFavoutite.bind { [unowned self] isFavourite in
            self.detailsView.likeButton.isSelected = isFavourite
        }
        
        viewModel.badgeCount.bind { [unowned self] value in
            if value != 0 {
                self.badge.text = value.description
                self.badge.isHidden = false
            } else {
                self.badge.isHidden = true
            }
        }
    }

    private func makeBadgeLabel() -> UILabel {
        let badgeSize: CGFloat = 20
        let badge = UILabel()
        badge.layer.cornerRadius = badgeSize / 2
        badge.layer.masksToBounds = true
        badge.backgroundColor = .systemRed
        badge.font = badge.font.withSize(12)
        badge.textColor = .white
        badge.textAlignment = .center
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
    private func didTapBackButton() {
        viewModel.backButtonTapped()
    }
    
    @objc
    private func didTapCartButton() {
        viewModel.cartButtonTapped()
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
    
    func likeButtonTapped() {
        viewModel.favouriteButtonTapped()
    }
    
    func capacityButtonTapped(tag: Int) {
        viewModel.selectCapacity(for: tag)
    }
    
    func colorButtonTapped(tag: Int) {
        viewModel.selectColor(for: tag)
    }
    
    func sectionButtonTapped(tag: Int) {
        viewModel.selectSection(for: tag)
    }
    
    func addToCartButtonTapped() {
        viewModel.addToCart()
    }
    
}
