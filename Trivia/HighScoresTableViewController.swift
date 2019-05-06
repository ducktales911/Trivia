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
    
    var thisPlayer = HighscoreModel(name: "", score: "")
    
    var playerItems = [HighscoreModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoresController.fetchItems(completion: { (playerItems) in
            
            DispatchQueue.main.async {
                
                if let playerItems = playerItems {
                    self.playerItems = playerItems
                    print(playerItems)
                    self.tableView.reloadData()
                } else {
                    print("Unable to load data.")
                }
            }
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
        
        playerItems = playerItems.sorted(by: { $0.score > $1.score} )
        cell.textLabel?.text = playerItems[indexPath.row].name
        cell.detailTextLabel?.text = playerItems[indexPath.row].score
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
