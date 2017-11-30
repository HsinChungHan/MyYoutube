//
//  Extensions.swift
//  Youtube
//
//  Created by 辛忠翰 on 25/11/17.
//  Copyright © 2017 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
extension UIColor{
    //static fumc 為了讓其他檔案也可以呼叫這個func
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}




extension UIView{
    func addConstraintsWithFormat(format: String, views: UIView...)  {
        var viewsDictionary = [String : UIView]()
        for(index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }    
}

//為了要解決每次滑動都會reloadUICollectionView的問題，我們需要將以下載的圖片暫存到cache中
let imageCache = NSCache<AnyObject, AnyObject>()
class CustomImageView: UIImageView{
    var imageUrlString: String?
    
    
    func loadImageUsingUrlString(urlStr: String){
        //因為若重新滑動，便會重新載入。所以當我第一次滑動，圖片還在下載，
        //此時若又在滑動，便會造成第一次下載完的圖片，放在第二次圖片應放的位置，而造成圖片錯位
        imageUrlString = urlStr
        
        if let url = URL(string: urlStr){
            //再重新抓圖片的過程中，先把圖片清空
            image = nil
            //每次要抓取先查看cache中是否有存照片，若有，就直接從cache中取出，然後return
            //若無，就把從網路上抓取
            if let imgInCache = imageCache.object(forKey: urlStr as AnyObject) as? UIImage{
                self.image = imgInCache
                return
            }
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil{
                    print(error.debugDescription)
                }
                guard let data = data else{return}
                DispatchQueue.main.async {
                    let imgToCache = UIImage(data: data)
                    //若發現兩者圖片名一致，才會設定image圖片
                    if self.imageUrlString == urlStr{
                        self.image = imgToCache
                    }
                    imageCache.setObject(imgToCache!, forKey: urlStr as AnyObject)
                }
            }).resume()
        }
    }
}


