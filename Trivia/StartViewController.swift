//
//  StartViewController.swift
//  Trivia
//
//  Created by Thomas on 29/04/2019.
//  Copyright © 2019 Thomas Hamburger. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    // Voor invoer van de gebruikersnaam die uiteindelijk in de High Score komt.
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Voert de segue naar GamePlayViewController uit.
    @IBAction func startButton(_ sender: Any) {
        if nameTextField.text != "" {
            performSegue(withIdentifier: "startSegue", sender: nil)
        }
    }

    // Nodig voor de "New Game" knop in HighScoreTableViewController.
    @IBAction func unwindToStart(_ sender: UIStoryboardSegue) {}

    // Segue naar de GamePlayViewController, zodat het spel begint.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startSegue" {
            let navigationController = segue.destination as! UINavigationController
            let gamePlayVC = navigationController.topViewController as! GamePlayViewController
            gamePlayVC.playerName = nameTextField.text!
        }
    }
}
