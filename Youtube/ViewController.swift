//
//  ViewController.swift
//  Youtube
//
//  Created by 辛忠翰 on 24/11/17.
//  Copyright © 2017 辛忠翰. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        return cell
    }
    
    
}
//
extension HomeController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    //每個cell的間距設為0
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

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
//        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let separatorView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.black
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userProfileImgView: UIImageView = {
       let imgView = UIImageView()
        imgView.backgroundColor = UIColor.green
        return imgView
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.backgroundColor = UIColor.purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.red
        textView.translatesAutoresizingMaskIntoConstraints = false
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
        addConstraintFormate(format: "H:|-16-[v0]-16-|", views: thumbnailImgView)
        addConstraintFormate(format: "H:|[v0]|", views: separatorView)
        addConstraintFormate(format: "H:|-16-[v0(44)]|", views: userProfileImgView)

        
        //vertical constrain
        addConstraintFormate(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImgView, userProfileImgView, separatorView)
        
        //titleLabel constrain
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImgView, attribute: .bottom, multiplier: 1, constant: 8))
        //height constraint
//        addConstraintFormate(format: "V:[v0(20)]", views: titleLabel)
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        //left constrain
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImgView, attribute: .right, multiplier: 1, constant: 8))
        //right constrain
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImgView, attribute: .right, multiplier: 1, constant: 0))
        
        //infoLabel constraint
        //top constrain
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 8))
        //height constraint
//        addConstraintFormate(format: "V:[v0(20)]", views: infoLabel)
        //hight: 如果想要根據label中的文字動態調整高度的話
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        //right constrain
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
        //left constrain
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1, constant: 0))

    }
    //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : thumbnailImgView]))
    //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-[v1(1)]|" , options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : thumbnailImgView, "v1": separatorView]))
    //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : separatorView]))
    //sepearatorView will be 1pix, and at the btm of cell
    //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|" , options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : seperatorView]))
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder: ) has not been implemented")
    }
}

extension UIView{
    func addConstraintFormate(format: String, views: UIView...)  {
        var viewsDictionary = [String : UIView]()
        for(index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}


