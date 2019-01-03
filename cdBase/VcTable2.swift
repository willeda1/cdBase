//
//  VcTable2.swift
//  cdBase
//
//  Created by David Wille on 03/01/2019.
//  Copyright © 2019 David Wille. All rights reserved.
//

import UIKit

class VcTable2: UIViewController {
    
    
    @IBOutlet weak var table1: UITableView!
    @IBOutlet weak var table2: UITableView!
    
    var tvc1 = TvcTable()
    var tvc2 = TvcTable()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tvc1.configure(queue:"table1", up: true)
  //      let tvc2 = TvcTable()
        table1.dataSource=tvc1
        table1.delegate=tvc1
        
        tvc2.configure(queue:"table2", up: false)
        table2.dataSource=tvc2
        table2.delegate=tvc2

    }
    

    
}
