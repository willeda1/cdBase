//
//  ViewController.swift
//  cdBase
//
//  Created by David Wille on 31/12/2018.
//  Copyright © 2018 David Wille. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var display: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDisplay()
    }
    
    @IBAction func add(_ sender: Any) {
        let person = Person(context: context)
        person.name = "david @ \(Date())"
        display.text="\([Person]())"
        updateDisplay()
    }
    
    func updateDisplay(){
        
        var entries = [Person]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Person")
        
        do {
            entries = try context.fetch(request) as! [Person]
            
            let noEntries = entries.count
            var displayText = "\(noEntries) entries\n"
            
            for entry in entries {
                displayText = displayText + "\n" + entry.name!
            }
            
            display.text=displayText
            
        } catch let error as NSError {
            display.text = "could not fetch \(error)"
        }
    }
    
    
}

