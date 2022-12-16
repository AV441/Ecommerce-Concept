//
//  DetailsView.swift
//  Ecommerce Concept
//
//  Created by Андрей on 12.12.2022.
//

import UIKit
import SnapKit
import Cosmos

protocol DetailViewDelegate {
    func didTapAddToCartButton()
}

final class DetailsView: UIView {
    
    var delegate: DetailViewDelegate?
    
    lazy var collectionView = makeCollectionView()
    lazy var containerView = makeContainerView()
    
    lazy var titleLabel = makeTitleLabel()
    lazy var likeButton = makeLikeButton()
    
    lazy var ratingView = makeRatingView()
    
    lazy var sectionButtonsStack = makeSectionButtonsStack()
    
    lazy var cpuLabel = makeCharacteristicLabel()
    lazy var cameraLabel = makeCharacteristicLabel()
    lazy var ssdLabel = makeCharacteristicLabel()
    lazy var sdLabel = makeCharacteristicLabel()
    
    lazy var cpuImageView = makeCharacteristicImageView(withImageName: "icCPU")
    lazy var cameraImageView = makeCharacteristicImageView(withImageName: "icCamera")
    lazy var ssdImageView = makeCharacteristicImageView(withImageName: "icSSD")
    lazy var sdImageView = makeCharacteristicImageView(withImageName: "icSD")
    
    lazy var selectColorAndCapacityLabel = makeSelectColorAndCapacityLabel()
    
    lazy var priceLabel = makePriceLabel()
    
    lazy var featuresStack = makeFeaturesStack()
    
    lazy var addToCartStack = makeAddToCartHStack()
    
    lazy var colorButtonsScrollView = makeColorButtonsScrollView()
    lazy var capacityButttonsScrollView = makeCapacityButtonsScrollView()
    
    var detailImages: [UIImageView] = []
    var sectionButtons: [SectionButton] = []
    var colorButtons: [UIButton] = []
    var capacityButtons: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "Background")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
