//
//  ViewController.swift
//  Trivia
//
//  Created by Thomas Hamburger on 13/12/2018.
//  Copyright © 2018 Thomas Hamburger. All rights reserved.
//

import UIKit
import HTMLString

let escapedEmoji = "My favorite emoji is &#x1F643;"
let emoji = escapedEmoji.removingHTMLEntities // "My favorite emoji is 🙃"

let escapedSnack = "Fish &amp; Chips"
let snack = escapedSnack.removingHTMLEntities // "Fish & Chips"

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    
    let questionURL = URL(string: "http://opentdb.com/api.php?amount=10")!
    //let queury: [String: String] = [
        
    //   ]
    
    
    
    
    override func viewDidLoad() {
        for button in answerButtons {
            button.setTitle("hi", for: .normal)
        }
        print(emoji)
        print(snack)

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

