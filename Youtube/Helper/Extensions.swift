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


extension UIImageView{
    func loadImageUsingUrlString(urlStr: String){
        if let url = URL(string: urlStr){
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil{
                    print(error.debugDescription)
                }
                guard let data = data else{
                    return
                }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }).resume()
        }
    }
}


