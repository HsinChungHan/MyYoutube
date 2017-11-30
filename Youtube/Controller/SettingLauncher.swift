//
//  SettingLauncher.swift
//  Youtube
//
//  Created by 辛忠翰 on 29/11/17.
//  Copyright © 2017 辛忠翰. All rights reserved.
//

import UIKit

class SettingInfo: NSObject{
    let labelName: String
    let imageName: String
    init(labelName: String, imageName: String) {
        self.labelName = labelName
        self.imageName = imageName
    }
}

class SettingLauncher: NSObject {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    let blackView = UIView()
    let settingInfos: [SettingInfo] = {
        let icons = ["settings", "privacy","feedback","help" ,"switch_account","cancel"]
        let names = ["Settings", "Terms & Privacy Pelly", "Send FeedBack", "Help", "Switch Account", "Cancel"]
        let item1 = SettingInfo.init(labelName: "Settings", imageName: "settings")
        let item2 = SettingInfo.init(labelName: "Terms & Privacy Pelly", imageName: "privacy")
        let item3 = SettingInfo.init(labelName: "Send FeedBack", imageName: "feedback")
        let item4 = SettingInfo.init(labelName: "Help", imageName: "help")
        let item5 = SettingInfo.init(labelName: "Switch Account", imageName: "switch_account")
        let item6 = SettingInfo.init(labelName: "Cancel", imageName: "cancel")
        return [item1, item2, item3, item4, item5, item6]
    }()
    @objc func showSettings(){
        //show menu
        //想要讓整個window都變黑的
        if let window = UIApplication.shared.keyWindow{//利用這行code抓到整個window
            blackView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)//讓他成為黑色，且黑色的透明度為50%
            window.addSubview(blackView)
            window.addSubview(collectionView)
            let yPosition = window.frame.height - CGFloat(settingInfos.count*50)
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: CGFloat(settingInfos.count)*cellHeight)
            blackView.frame = window.frame
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            //接下來讓blackView的出現有延遲的動畫感
            blackView.alpha = 0//這代表整個view的透明度，所以此時黑色的透明度為0.5，整個blackView的可視程度為0%
            //延遲時間加上spring動畫(faster beginning, slowdown ending)
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1//這代表整個view的透明度，所以此時黑色的透明度為0.5，整個blackView的可視程度為100%
                self.collectionView.frame = CGRect(x: 0, y: yPosition, width: window.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
            //這只是單純的延遲時間
            /*
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 1//這代表整個view的透明度，所以此時黑色的透明度為0.5，整個blackView的可視程度為100%
                self.collectionView.frame = CGRect(x: 0, y: yPosition, width: window.frame.width, height: self.cvHeight)
            })
            */
            collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
        }
    }
    @objc func handleDismiss() {
        guard let window = UIApplication.shared.keyWindow else{return}
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow{
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: self.collectionView.frame.height)
            }
        }
        
    }
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}


extension SettingLauncher: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingInfos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        cell.settingInfo = settingInfos[indexPath.item]
        return cell
    }
}

extension SettingLauncher: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }

    //因為UICollectionView預設會有CGFloat(10)的間隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}








