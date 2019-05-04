//
//  ViewController.swift
//  Trivia
//
//  Created by Thomas Hamburger on 13/12/2018.
//  Copyright © 2018 Thomas Hamburger. All rights reserved.
//

import UIKit
import HTMLString

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let questionController = QuestionItemController()
    
    let player = PlayerItemController()
    
    var items = [QuestionItem]()
    
    var score = 0
    var playerName = ""
    
    var questionCounter = 0
    
    func fetchQuestions() {
        self.items = []
        let query = [
            "amount": "10"
        ]
        
        questionController.fetchItems(matching: query, completion: { (items) in
            
            DispatchQueue.main.async {
                
                if let items = items {
                    self.items = items
                    print(items)
                    self.nextQuestion(number: self.questionCounter)
                } else {
                    print("Unable to load data.")
                }
            }
        })
    }
    
    func updateButtons(answers: [String]) {
        
        // Aantal knoppen = aantal antwoord-opties
        if answers.count == 2 {
            answerButtons[2].isHidden = true
            answerButtons[3].isHidden = true
        } else {
            answerButtons[2].isHidden = false
            answerButtons[3].isHidden = false
        }
        
        // Stel de knoptekst in
        for (index, element) in answers.enumerated() {            answerButtons[index].setTitle(element.removingHTMLEntities, for: .normal)
        }
    }
    
    func nextQuestion(number: Int) {
        self.progressLabel.text = "Question \(questionCounter + 1) of \(items.count)"
        self.questionLabel.text = items[number].question.removingHTMLEntities // laat alleen nog eerste vraag zien
        var allAnswers = items[number].incorrectAnswers + [items[number].correctAnswer]
        allAnswers.shuffle()
        self.updateButtons(answers: allAnswers)
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            sender.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
        if (questionCounter < items.count) {
            print("items:", items.count)
            print("questionCounter:", questionCounter)
            print(sender.title(for: .normal)!)
            if sender.title(for: .normal)! == items[questionCounter].correctAnswer {
                print("CORRECT!")
                score += 1
                scoreLabel.text = "Score: \(score)"
            } else {
                print("WRONG ANSWER!")
            }
            questionCounter += 1
        }
        if (questionCounter < items.count) {
            nextQuestion(number: questionCounter)
        } else {
            print(score)
            let finalScore = PlayerItem(name: playerName, score: String(score))
            player.postItem(player: finalScore)
            performSegue(withIdentifier: "showHighscore", sender: answerButtons)
            print("hello")
        }
    }
    
    
    
    
    override func viewDidLoad() {
        questionLabel.text = ""
        questionCounter = 0
        score = 0
        for button in answerButtons {
            button.setTitle("", for: .normal)
            button.layer.cornerRadius = 15.0
        }
        print(playerName)
        
        fetchQuestions()

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

