//
//  ViewController.swift
//  Trivia
//
//  Created by Thomas Hamburger on 13/12/2018.
//  Copyright © 2018 Thomas Hamburger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    
    let questionURL = "http://opentdb.com/api.php?amount=10"
    
    
    
    
    
    override func viewDidLoad() {
        for button in answerButtons {
            button.setTitle("hi", for: .normal)
        }

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

