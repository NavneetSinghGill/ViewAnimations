//
//  ViewController.swift
//  ViewAnimation
//
//  Created by Navneet on 12/21/17.
//  Copyright © 2017 Navneet. All rights reserved.
//

import UIKit

class ViewController: BPViewController {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var butt: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.butt.tag = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.imageV.BPDelay = 100
    }
    
    @IBAction func loginTapped() {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
        self.bpPush(viewController: secondVC!)
    }


}

