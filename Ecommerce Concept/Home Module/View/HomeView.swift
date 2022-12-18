//
//  HomeViewController+extension.swift
//  Ecommerce Concept
//
//  Created by Андрей on 10.12.2022.
//

import UIKit
import SnapKit

final class HomeView: UIView {
    
    lazy var collectionView = makeCollectionView()
    
    lazy var tabView = makeTabView()
    
    lazy var explorerButton = makeButton(title: " Explorer",
                                    image: UIImage(named: "icExplorer"))
    lazy var cartButton = makeButton(title: nil,
                                image: UIImage(named: "icCart"))
    lazy var favoritesButton = makeButton(title: nil,
                                     image: UIImage(named: "icFavorites"))
    lazy var profileButton = makeButton(title: nil,
                                   image: UIImage(named: "icProfile"))
    
    var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Midnight")
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "Background")
        
//        addSubview(bottomView)
        addSubview(collectionView)
        addSubview(tabView)

//        bottomView.snp.makeConstraints { make in
//            make.leading.trailing.bottom.equalToSuperview()
//            make.height.equalTo(30)
//        }
        
        tabView.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.leading.trailing.bottom.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().offset(-72)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
