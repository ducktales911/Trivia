//
//  GamePlayViewController.swift
//  Trivia
//
//  Created by Thomas Hamburger on 13/12/2018.
//  Copyright © 2018 Thomas Hamburger. All rights reserved.
//

import UIKit
import HTMLString

class GamePlayViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var prograssBar: UIView!
    
    let questionController = TriviaController()
    let player = HighScoresController()
    var allQuestions = [QuestionModel]()
    var score = 0
    var playerName = ""
    var questionNumber = 0
    
    func fetchQuestions() {
        self.allQuestions = []
        let query = [
            "amount": "10"
        ]
        
        questionController.fetchItems(matching: query, completion: { (items) in
            
            DispatchQueue.main.async {
                
                if let items = items {
                    self.allQuestions = items
                    print(items)
                    self.updateUI(number: self.questionNumber)
                } else {
                    print("Unable to load data.")
                }
            }
        })
    }
    
    func updateUI(number: Int) {
        self.prograssBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.count)) * CGFloat(questionNumber + 1)
        self.progressLabel.text = "\(questionNumber + 1) / \(allQuestions.count)"
        self.questionLabel.text = allQuestions[number].question.removingHTMLEntities // laat alleen nog eerste vraag zien
        var allAnswers = allQuestions[number].incorrectAnswers + [allQuestions[number].correctAnswer]
        allAnswers.shuffle()
        self.updateButtons(answers: allAnswers)
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
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            sender.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
        if (questionNumber < allQuestions.count) {
            print(sender.title(for: .normal)!)
            if sender.title(for: .normal)! == allQuestions[questionNumber].correctAnswer {
                print("CORRECT!")
                score += 1
                scoreLabel.text = "Score: \(score)"
            } else {
                print("WRONG ANSWER!")
            }
            questionNumber += 1
        }
        if (questionNumber < allQuestions.count) {
            updateUI(number: questionNumber)
        } else {
            showHighScore()
        }
    }
    
    func showHighScore() {
        print(score)
        let finalScore = HighscoreModel(name: playerName, score: String(score))
        player.postItem(player: finalScore)
        performSegue(withIdentifier: "showHighscore", sender: answerButtons)
    }
    
    override func viewDidLoad() {
        questionLabel.text = ""
        questionNumber = 0
        score = 0
        for button in answerButtons {
            button.setTitle("", for: .normal)
            button.layer.cornerRadius = 15.0
        }
        fetchQuestions()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }

}

