//
//  ViewController.swift
//  ViewAnimation
//
//  Created by Navneet on 12/21/17.
//  Copyright © 2017 Navneet. All rights reserved.
//

import UIKit
import BPViewsSubviewsInOutAnimation

class FirstViewController: BPViewController {    
    
    @IBOutlet weak var floatTF: FloatingHeaderTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginTapped() {
//        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
//        self.bpPush(viewController: secondVC!)
        floatTF.isActive = true
    }
    
    @IBAction func login2Tapped() {
        floatTF.isActive = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}

