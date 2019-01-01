//
//  ViewController.swift
//  cdBase
//
//  Created by David Wille on 31/12/2018.
//  Copyright © 2018 David Wille. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let person = Person(context: context)
        person.info()
    }


}

