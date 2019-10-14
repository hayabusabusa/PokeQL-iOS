//
//  MainGridCell.swift
//  PokeQL-iOS
//
//  Created by 山田隼也 on 2019/10/14.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import UIKit
import Kingfisher

class MainGridCell: UICollectionViewCell {

    // MARK: IBOutlet
    
    @IBOutlet private weak var mainImageView: UIImageView!
    
    // MARK: Properties
    
    static let reuseIdentifier = "MainGridCell"
    static var nib: UINib {
        return UINib(nibName: "MainGridCell", bundle: nil)
    }
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 4
    }
    
    // MARK: Configure
    
    func configureCell(_ url: String) {
        if let url = URL(string: url) {
            mainImageView.kf.setImage(with: url, placeholder: UIImage(named: "ic_no_image"), options: [.transition(.fade(0.3))])
        }
    }
}
