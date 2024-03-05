//
//  UIImageView+Extension.swift
//  ProductsListMVVM
//
//  Created by Abhishek Gupta on 05/03/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with imageURL: String) {
        guard let url = URL(string: imageURL) else {
             return
        }
        let resource = KF.ImageResource(downloadURL: url, cacheKey: imageURL)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}

