//
//  TabBarView.swift
//  manager
//
//  Created by 福田隆史 on 2017/09/24.
//  Copyright © 2017年 f.R. All rights reserved.
//

import Foundation
import FontAwesome_swift
import UIKit


class TabBarView: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tabBar.tintColor = UIColor.green
        self.tabBar.backgroundColor = #colorLiteral(red: 0.1260755658, green: 0.5765528083, blue: 0.4566453695, alpha: 1)
        
        self.tabBar.items![0].image = UIImage.fontAwesomeIcon(name: .home, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
        
        self.tabBar.items![1].image = UIImage.fontAwesomeIcon(name: .addressBookO, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
        
        self.tabBar.items![2].image = UIImage.fontAwesomeIcon(name: .addressBook, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
