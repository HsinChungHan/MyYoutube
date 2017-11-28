//
//  MenuBar.swift
//  Youtube
//
//  Created by 辛忠翰 on 25/11/17.
//  Copyright © 2017 辛忠翰. All rights reserved.
//

import UIKit
class MenuBar: UIView {
    //如果用let的話cv.delegate = self和cv.dataSource = self，這兩個會不通過，所以需要用lazy var
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let cellId = "cellId"
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: cellId)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        //一進到畫面就讓scrollView選擇item = 0, section = 0
        let selectionIndexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectionIndexPath as IndexPath, animated: false, scrollPosition: .top)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder: ) has not been implemented")
    }
    
    let menuBarImgNames = ["home", "account", "subscriptions", "trending"]
    
    
}

extension MenuBar: UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuBarCell
        //幫預設的imgView上覆蓋一層黑色的圖層，imgView.image = UIImage(named: "home")也要添加.withRenderingMode(.alwaysTemplate)。也需要在cell.itemImgView.image中添加此行程式碼
        cell.itemImgView.image = UIImage(named: menuBarImgNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        
        return cell
    }
    
    
}

extension MenuBar: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/4, height: frame.height)
    }
    
    // 讓同個setion的cell的間距成為0
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class MenuBarCell: BsicCell {
    //當滑鼠點到的時候，以及選擇的時候，想要讓他做一些事情的時候。以下兩個參數可以使用
    override var isHighlighted: Bool{
        didSet{
            itemImgView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
            selectedBarView.backgroundColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 230, green: 32, blue: 31)
        }
    }
    
    override var isSelected: Bool{
        didSet{
            itemImgView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
            selectedBarView.backgroundColor = isSelected ? UIColor.white : UIColor.rgb(red: 230, green: 32, blue: 31)
        }
    }
    
    let itemImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        //幫預設的imgView上覆蓋一層黑色的圖層，同時上面那行imgView.image = UIImage(named: "home")也要添加.withRenderingMode(.alwaysTemplate)。也需要在cell.itemImgView.image中添加此行程式碼
        imgView.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        //        imgView.contentMode = .scaleAspectFill
        //        imgView.clipsToBounds = true
        return imgView
    }()
    
    let selectedBarView: UIView = {
        let view = UIView()
        return view
    }()
    override func setUpViews() {
        super.setUpViews()
        addSubview(itemImgView)
        addSubview(selectedBarView)
        //一開始在這邊卡住很久，發現Visual format language的優先極大於addConstraint(NSLayoutConstraint(item: itemImgView, attribute:...的優先級。所以"V:|[v0(28)]|"應該改為"V:[v0(28)]"
        //        addConstraintsWithFormat(format: "V:|[v0(28)]|", views: itemImgView)
        //        addConstraintsWithFormat(format: "H:|[v0(28)]|", views: itemImgView)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: itemImgView)
        addConstraintsWithFormat(format: "H:[v0(28)]", views: itemImgView)
        //讓imgView在cell的正中間
        addConstraint(NSLayoutConstraint(item: itemImgView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: itemImgView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        
        addConstraintsWithFormat(format: "V:[v0(4)]|", views: selectedBarView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: selectedBarView)
        
    }
}


