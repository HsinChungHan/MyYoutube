//
//  SettingCell.swift
//  Youtube
//
//  Created by 辛忠翰 on 29/11/17.
//  Copyright © 2017 辛忠翰. All rights reserved.
//

import UIKit
class SettingCell: BasicCell {
    override var isHighlighted: Bool{
        didSet{
            cellImageView.backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            //要讓icon在點按的時候，變為有白色色調，放開時，回復為darkGray的色調
            //同時也要在settingInfo中的didSet的iconImageView.image = UIImage(named: imgName)?添加.withRenderingMode(.alwaysTemplate)
            //但因為.alwaysTemplate會使得iconImg是系統預設的藍色，所以要自己手動設定tintColor一開始為darkGray
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var settingInfo: SettingInfo? {
        didSet{
            nameLabel.text = (settingInfo?.labelName).map { $0.rawValue }
            guard let imgName = settingInfo?.imageName else{return}
            iconImageView.image = UIImage(named: imgName)?.withRenderingMode(.alwaysTemplate)
            //但因為.alwaysTemplate會使得iconImg是系統預設的藍色，所以要自己手動設定tintColor一開始為darkGray
            iconImageView.tintColor = UIColor.darkGray
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
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
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
