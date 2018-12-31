//
//  ViewController.swift
//  cdBase
//
//  Created by David Wille on 31/12/2018.
//  Copyright © 2018 David Wille. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let person = Person(context: context)
        person.info()
    }


}

