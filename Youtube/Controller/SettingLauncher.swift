//
//  SettingLauncher.swift
//  Youtube
//
//  Created by 辛忠翰 on 29/11/17.
//  Copyright © 2017 辛忠翰. All rights reserved.
//

import UIKit
class SettingLauncher: NSObject {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.delegate = self
//        cv.dataSource = self
        return cv
    }()
    
//    let cellId = "cellId"
    
    let blackView = UIView()
    let window = UIApplication.shared.keyWindow
    
    @objc func showSettings(){
        //show menu
        //想要讓整個window都變黑的
        if let window = UIApplication.shared.keyWindow{//利用這行code抓到整個window
            blackView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)//讓他成為黑色，且黑色的透明度為50%
            window.addSubview(blackView)
            window.addSubview(collectionView)
            let cvHeight: CGFloat = 200
            let yPosition = window.frame.height - cvHeight
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: cvHeight)
            blackView.frame = window.frame
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            //接下來讓blackView的出現有延遲的動畫感
            blackView.alpha = 0//這代表整個view的透明度，所以此時黑色的透明度為0.5，整個blackView的可視程度為0%
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 1//這代表整個view的透明度，所以此時黑色的透明度為0.5，整個blackView的可視程度為100%
                self.collectionView.frame = CGRect(x: 0, y: yPosition, width: window.frame.width, height: cvHeight)
            })
            
        }
    }
    @objc func handleDismiss() {
        guard let window = UIApplication.shared.keyWindow else{return}
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 0)
        }
        
    }
    
    override init() {
        super.init()
        
    }
}

//extension SettingLauncher: UICollectionViewDelegate, UICollectionViewDataSource{
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 0
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell =     collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
//        return cell
//    }
//}
//
//extension SettingLauncher: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/5)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}
//
//class SettingLauncherCell: BsicCell {
//    let imageView: UIImageView = {
//        let imgView = UIImageView()
//        imgView.backgroundColor = UIColor.red
//        return imgView
//    }()
//    override func setUpViews() {
//        super.setUpViews()
//        addSubview(imageView)
//    }
//}






