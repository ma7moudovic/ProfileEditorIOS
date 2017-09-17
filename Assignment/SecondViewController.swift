//
//  SecondViewController.swift
//  Assignment
//
//  Created by Mahmoud El Sharkawy on 9/17/17.
//  Copyright © 2017 Mahmoud El Sharkawy. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(user?.name)
        print(user?.showName)
        print(user?.email)
        print(user?.age)
        print(user?.country)
        print(user?.gender)
        
        
        
    }
    
}
