//
//  HomeController.swift
//  Youtube
//
//  Created by 辛忠翰 on 27/11/17.
//  Copyright © 2017 辛忠翰. All rights reserved.
//

import Foundation
import UIKit

class HomeController: UICollectionViewController {
    var videos: [Video]?
    func fetchVideos() {
        guard let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")else{
            return
        }
        URLSession.shared.dataTask(with: url){(data, response, error) in
            //利用swift4的方式去Parse JSON
            let HTTPSStatusCode = (response as! HTTPURLResponse).statusCode
            if HTTPSStatusCode == 200 && error == nil{
                guard let data = data else{return}
                do{
                    self.videos = try JSONDecoder().decode([Video].self, from: data)
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }catch let jsonErr{
                    print(jsonErr.localizedDescription)
                }
            }
            //這些程式碼可以爬jsom的檔案下來(但未解析得很漂亮)
            //            let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            //            print(str)
            }.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideos()
        navigationItem.title = "Home"
        //讓navigation bar 不要變透明的，會讓我們的bar顏色更真實
        navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "Home"
        navigationItem.titleView = titleLabel
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        //因為我們上面有個MenuBar，所以collectionView需要整個下移50
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        //要讓scrollView在滑動的時候，正好停在離top 50的位置
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func setupNavBarButtons(){
        //.alwaysOriginal為了要使用原本的icon的樣子，因為在navigationBar上他會有一個讓他變成藍色樣子的template
        let searchImg = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImg, style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMoreBtn))
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    @objc func handleSearch() {
        print(123)
    }
    
    let settingLauncher = SettingLauncher()
    @objc func handleMoreBtn(){
        settingLauncher.showSettings()
    }
    
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    private func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]|", views: menuBar)
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    
}

extension HomeController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - WINDOW_PADDING * 2) * PICTURE_HEIGHT_DIVIDE_WIDTH
        return CGSize(width: view.frame.width, height: height + CELL_PROFILEIMG_PADDING + +PROFILE_IMGVIEW_HEIGHT+USER_PROFILE_IMGVIEW_TO_WINDOW)
    }
    
    //每個cell的間距設為0
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
