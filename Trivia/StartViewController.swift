//
//  StartViewController.swift
//  Trivia
//
//  Created by Thomas on 29/04/2019.
//  Copyright © 2019 Thomas Hamburger. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButton(_ sender: Any) {
        if nameTextField.text != "" {
            performSegue(withIdentifier: "startSegue", sender: nil)
        }
    }
    
    @IBAction func unwindToStart(_ sender: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "startSegue" {
            let nav = segue.destination as! UINavigationController
            let svc = nav.topViewController as! GamePlayViewController
            svc.playerName = nameTextField.text!
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
