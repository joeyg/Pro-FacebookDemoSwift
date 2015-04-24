
//
//  BackSegue.swift
//  FacebookDemoSwift
//
//  Created by Joe Gasiorek on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BackSegue: UIStoryboardSegue {
    override func perform() {
        self.sourceViewController.navigationController!!.dismissViewControllerAnimated(true, completion:nil)

        
    }
}
