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
    let highScoreController = HighScoresController()
    var allQuestions = [QuestionModel]()
    var score = 0
    var playerName = ""
    var questionNumber = 0

    // Haal alle vragen op en bewaar ze in een array.
    func fetchQuestions() {
        allQuestions = []
        let query = [
            "amount": "10"
        ]
        questionController.fetchItems(matching: query, completion: { (items) in
            DispatchQueue.main.async {
                if let items = items {
                    self.allQuestions = items
                    self.updateUI()
                } else {
                    print("Unable to load data.")
                }
            }
        })
    }

    // Toon nieuwe vragen, update de voortgangsbalk, score label en label voor vraagnummer.
    func updateUI() {
            prograssBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.count)) * CGFloat(questionNumber + 1)
            progressLabel.text = "\(questionNumber + 1) / \(allQuestions.count)"
            scoreLabel.text = "Score: \(score)"
            // laat alleen nog eerste vraag zien
            questionLabel.text = allQuestions[questionNumber].question.removingHTMLEntities
            var allAnswers = allQuestions[questionNumber].incorrectAnswers + [allQuestions[questionNumber].correctAnswer]
            allAnswers.shuffle()
            updateButtons(answers: allAnswers)
    }

    // Laat de juiste hoeveelheid knoppen zien en past de knoptekst aan.
    func updateButtons(answers: [String]) {
        // Aantal knoppen = aantal antwoord-opties.
        if answers.count == 2 {
            answerButtons[2].isHidden = true
            answerButtons[3].isHidden = true
        } else {
            answerButtons[2].isHidden = false
            answerButtons[3].isHidden = false
        }

        for (index, element) in answers.enumerated() {
            answerButtons[index].setTitle(element.removingHTMLEntities, for: .normal)
        }
    }

    // Acties na het tikken op een antwoordknop door gebruiker.
    @IBAction func buttonTapped(_ sender: UIButton) {
        let selectedAnswer = sender.title(for: .normal)!
        let correctAnswer = allQuestions[questionNumber].correctAnswer.removingHTMLEntities

        // Check of het antwoord correct is, update de score en geef melding.
        if selectedAnswer == correctAnswer {
            score += 50
            showFeedbackAlert(title: "Correct!", message: "", duration: 750)
        } else {
            score -= 30
            showFeedbackAlert(title: "Wrong!", message: "The answer was: \(correctAnswer)", duration: 1500)
        }
        // Als er vragen over zijn naar volgende vraag. Anders alleen de score updaten.
        if !isLastQuestion() {
            questionNumber += 1
            updateUI()
        } else {
            scoreLabel.text = "Score: \(score)"
        }
    }

    // Return true als huidige vraag de laatste is.
    func isLastQuestion() -> Bool {
        return (questionNumber == allQuestions.count - 1)
    }

    // Maak HighscoreModel object aan en gebruikt de postItem functie van HighScoresController om de score te uploaden.
    func postHighScore() {
        let finalScore = HighscoreModel(name: playerName, score: String(score))
        highScoreController.postItem(player: finalScore)
    }

    // Geef na elk antwoord een default iOS alert weer. Geef bij fout antwoord aan welk antwoord wel goed was. Geef na de laatste vraag ook de eindscore weer.
    func showFeedbackAlert(title: String, message: String, duration: Int? = nil) {
        let alert = UIAlertController(title: title, message:
            message, preferredStyle: .alert)

        if isLastQuestion() {
            postHighScore()
            alert.message = message + "\n And your final score is: \n \(score)"
            let highScoreAction = UIAlertAction(title: "Show Highscore", style: .default) { UIAlertAction in
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

    // Stel alle variabelen weer in op initiele waarden na het starten van een nieuwe game.
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
    }

    // Verberg Navigation Bar in de het GamePlay view.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    // Laat de Navigation bar weer zien in de High Score view.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

}
