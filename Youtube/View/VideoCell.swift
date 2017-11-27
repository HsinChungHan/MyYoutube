//
//  VideoCell.swift
//  Youtube
//
//  Created by 辛忠翰 on 25/11/17.
//  Copyright © 2017 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
class VideoCell: UICollectionViewCell {
    //當我們每次呼叫dequeueReusableCell都會呼叫這個init func
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    let thumbnailImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = UIColor.blue
        imgView.image = UIImage(named: "test")
        //單設定.scaleAspectFill會讓圖片超出範圍，所以要裁減圖片
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        //        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        //        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userProfileImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "test2")
        //讓userProfile變圓的
        imgView.layer.cornerRadius = CGFloat(PROFILE_IMGVIEW_HEIGHT/2)
        imgView.layer.masksToBounds = true
        
        imgView.backgroundColor = UIColor.green
        return imgView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hsin Reed - Do not yell to me!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "HsinReedVEVO - 14,446,587,980 views - 1 years ago"
        //原textView預設內容文字會與左boader有4 pixels的距離
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    
    
    func setUpViews(){
        addSubview(thumbnailImgView)
        addSubview(separatorView)
        addSubview(userProfileImgView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        thumbnailImgView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        //horizon constrain
        addConstraintsWithFormat(format: "H:|-\(WINDOW_PADDING)-[v0]-\(WINDOW_PADDING)-|", views: thumbnailImgView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        addConstraintsWithFormat(format: "H:|-\(WINDOW_PADDING)-[v0(\(PROFILE_IMGVIEW_HEIGHT))]|", views: userProfileImgView)
        
        
        //vertical constrain
        addConstraintsWithFormat(format: "V:|-\(WINDOW_PADDING)-[v0]-\(CELL_PROFILEIMG_PADDING)-[v1(\(PROFILE_IMGVIEW_HEIGHT))]-\(WINDOW_PADDING)-[v2(1)]|", views: thumbnailImgView, userProfileImgView, separatorView)
        
        //titleLabel constrain
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImgView, attribute: .bottom, multiplier: 1, constant: CGFloat(CELL_PROFILEIMG_PADDING)))
        //height constraint
        //        addConstraintFormate(format: "V:[v0(20)]", views: titleLabel)
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        //left constrain
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImgView, attribute: .right, multiplier: 1, constant: CGFloat(CELL_PROFILEIMG_PADDING)))
        //right constrain
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImgView, attribute: .right, multiplier: 1, constant: 0))
        
        //infoLabel constraint
        //top constrain
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //height constraint
        //        addConstraintFormate(format: "V:[v0(20)]", views: infoLabel)
        //hight: 如果想要根據label中的文字動態調整高度的話
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        //right constrain
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
        //left constrain
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1, constant: 0))
        
    }
    //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(WINDOW_PADDING)-[v0]-\(WINDOW_PADDING)-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : thumbnailImgView]))
    //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(WINDOW_PADDING)-[v0]-\(WINDOW_PADDING)-[v1(1)]|" , options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : thumbnailImgView, "v1": separatorView]))
    //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : separatorView]))
    //sepearatorView will be 1pix, and at the btm of cell
    //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|" , options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : seperatorView]))
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder: ) has not been implemented")
    }
}
