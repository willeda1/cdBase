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

    override func viewDidLoad() {
        super.viewDidLoad()

        let tvc1 = TvcTable()
  //      let tvc2 = TvcTable()
        
        table1.dataSource=tvc1
        table2.delegate=tvc1

    }
    

    
}
