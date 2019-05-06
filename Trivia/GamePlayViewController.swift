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
        allQuestions = []
        let query = [
            "amount": "10"
        ]
        
        questionController.fetchItems(matching: query, completion: { (items) in
            
            DispatchQueue.main.async {
                
                if let items = items {
                    self.allQuestions = items
                    print(items)
                    self.updateUI()
                } else {
                    print("Unable to load data.")
                }
            }
        })
    }
    
    func updateUI() {
            print(questionNumber)
            prograssBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.count)) * CGFloat(questionNumber + 1)
            progressLabel.text = "\(questionNumber + 1) / \(allQuestions.count)"
            scoreLabel.text = "Score: \(score)"
            questionLabel.text = allQuestions[questionNumber].question.removingHTMLEntities // laat alleen nog eerste vraag zien
            var allAnswers = allQuestions[questionNumber].incorrectAnswers + [allQuestions[questionNumber].correctAnswer]
            allAnswers.shuffle()
            updateButtons(answers: allAnswers)
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
        let selectedAnswer = sender.title(for: .normal)!
        let correctAnswer = allQuestions[questionNumber].correctAnswer.removingHTMLEntities
        if (selectedAnswer == correctAnswer) {
            score += 50
            showFeedbackAlert(title: "Correct!", message: "", duration: 500)
        } else {
            score -= 30
            showFeedbackAlert(title: "Wrong!", message: "The answer was: \(correctAnswer)", duration: 1000)
        }
        if (!isLastQuestion()) {
            questionNumber += 1
            updateUI()
        } else {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    func isLastQuestion() -> Bool {
        return (questionNumber == allQuestions.count - 1)
    }
    
    func postHighScore() {
        let finalScore = HighscoreModel(name: playerName, score: String(score))
        player.postItem(player: finalScore)
    }
    
    //
    func showFeedbackAlert(title: String, message: String, duration: Int? = nil) -> Void
    {
        let alert = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        
        if isLastQuestion() {
            postHighScore()
            alert.message = message + "\n And your final score is: \n \(score)"
            let highScoreAction = UIAlertAction(title: "Show Highscore", style: .default) {
                UIAlertAction in
                self.performSegue(withIdentifier: "showHighscore", sender: UIAlertAction)
            }
            alert.addAction(highScoreAction)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(duration!)) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
        present(alert, animated: true, completion: nil)
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
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }

}

