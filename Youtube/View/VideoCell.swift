//
//  VideoCell.swift
//  Youtube
//
//  Created by 辛忠翰 on 25/11/17.
//  Copyright © 2017 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
class VideoCell: BasicCell {
    //當我們每次呼叫dequeueReusableCell都會呼叫這個init func
    var video: Video?{
        didSet {
            //只要cell呼叫新的video，都可以讓cell中的元素依照video的member去做改變
            titleLabel.text = video?.title
            setupthumbnailImg()
            setupProfileImg()
            guard let channelName = video?.channel?.name else {
                return
            }
            
            //將數字每三位一數，ex:4,324,123,134
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            guard let numberOfViews = numberFormatter.string(from: (video?.number_of_views as NSNumber?)!)  else {
                return
            }
            let subtitleText = "\(channelName) - \(numberOfViews) - 2 years ago"
            subtitleTextView.text = subtitleText
            
            //measure titleLabel text
            guard let title = video?.title else{
                return
            }
            //先計算目前的UILabel的整個大小會是多少(非根據字數內容，而是一開始設定的constraint)。
            //hight隨意給一個很大的值
            let titleLableSize = CGSize(width: frame.size.width - PROFILE_IMGVIEW_HEIGHT - WINDOW_PADDING*2 - CELL_PROFILEIMG_PADDING, height: 1000)
            print("titleLableSize:\(titleLableSize.width)")
            //在設定NSStringDrawingOptions，直接用即可
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            //再計算目前的text的字數會是多大的rect(attribute:調整字體大小)
            let estimatedRect = NSString(string: title).boundingRect(with: titleLableSize, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
            if estimatedRect.size.height > 16 {
                //若計算後高度超過20，調整titleLabelHightConstraint到44
                titleLabelHightConstraint?.constant = 44
            }else{
                titleLabelHightConstraint?.constant = 20
            }
        }
    }
    
    
    let thumbnailImgView: CustomImageView = {
        let imgView = CustomImageView()
        imgView.backgroundColor = UIColor.white
        //這邊的code可以當作預設的圖片
        imgView.image = UIImage(named: "test")
        //單設定.scaleAspectFill會讓圖片超出範圍，所以要裁減圖片
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        //        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    func setupthumbnailImg() {
        guard let thumbnailImgName = video?.thumbnail_image_name else{return}
        thumbnailImgView.loadImageUsingUrlString(urlStr: thumbnailImgName)
    }
    
    func setupProfileImg(){
        guard let profileImgName = video?.channel?.profile_image_name else{return}
        userProfileImgView.loadImageUsingUrlString(urlStr: profileImgName)
    }
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        //        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userProfileImgView: CustomImageView = {
        let imgView = CustomImageView()
        imgView.image = UIImage(named: "test2")
        //讓userProfile變圓的
        imgView.layer.cornerRadius = CGFloat(PROFILE_IMGVIEW_HEIGHT/2)
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.backgroundColor = UIColor.green
        return imgView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hsin Reed - Do not yell me!"
        //讓這個label有兩行
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
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
    
    //如果今天UILabel的字數過多，可能會跑到第二行，此時便會需要動態測量label的高度，以及螢幕的寬度，動態去調整cell的高度
    
    var titleLabelHightConstraint: NSLayoutConstraint?
    override func setUpViews(){
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
        addConstraintsWithFormat(format: "V:|-\(WINDOW_PADDING)-[v0]-\(CELL_PROFILEIMG_PADDING)-[v1(\(PROFILE_IMGVIEW_HEIGHT))]-\(USER_PROFILE_IMGVIEW_TO_WINDOW)-[v2(1)]|", views: thumbnailImgView, userProfileImgView, separatorView)
        
        //titleLabel constrain
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImgView, attribute: .bottom, multiplier: 1, constant: CGFloat(CELL_PROFILEIMG_PADDING)))
        //height constraint
        //        addConstraintFormate(format: "V:[v0(20)]", views: titleLabel)
        titleLabelHightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHightConstraint!)
        
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
    
}
