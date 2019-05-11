//
//  HighScoresTableViewController.swift
//  Trivia
//
//  Created by Thomas on 04/05/2019.
//  Copyright © 2019 Thomas Hamburger. All rights reserved.
//

import UIKit

class HighScoresTableViewController: UITableViewController {

    let scoresController = HighScoresController()
    // Een HighscoreModel voor de score van de huidige speler.
    var thisPlayer = HighscoreModel(name: "", score: "")
    // Array om alle scores uit de database in op te slaan.
    var scoreItems = [HighscoreModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Haal scores op uit de database en plaats ze in de scoreItems array.
        scoresController.fetchItems(completion: { (scoreItems) in
            DispatchQueue.main.async {
                if let scoreItems = scoreItems {
                    self.scoreItems = scoreItems
                    self.tableView.reloadData()
                } else {
                    print("Unable to load data.")
                }
            }
        })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreItems.count
    }

    // Laad de de inhoud van de scoreItems array in de tableView cellen. Sorteert scores aflopend.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
        scoreItems = scoreItems.sorted(by: {Int($0.score)! > Int($1.score)!})
        cell.textLabel?.text = scoreItems[indexPath.row].name
        cell.detailTextLabel?.text = scoreItems[indexPath.row].score
        return cell
    }
}
