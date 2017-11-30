//
//  SettingCell.swift
//  Youtube
//
//  Created by 辛忠翰 on 29/11/17.
//  Copyright © 2017 辛忠翰. All rights reserved.
//

import UIKit
class SettingCell: BasicCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    var settingInfo: SettingInfo? {
        didSet{
            nameLabel.text = settingInfo?.labelName
            guard let imgName = settingInfo?.imageName else{return}
            iconImageView.image = UIImage(named: imgName)
        }
    }
    let cellImageView: UIView = {
        let imgView = UIView()
        imgView.backgroundColor = UIColor.white
        return imgView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    let iconImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "feedback")
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    func setupCell() {
        addSubview(cellImageView)
        cellImageView.addSubview(nameLabel)
        cellImageView.addSubview(iconImageView)

        addConstraintsWithFormat(format: "V:|[v0]|", views: cellImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: cellImageView)
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: cellImageView, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder: ) has not been implemented")
    }
}
