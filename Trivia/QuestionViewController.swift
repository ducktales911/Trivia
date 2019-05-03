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
    
    let questionController = QuestionItemController()
    
    var items = [QuestionItem]()
    
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
        
        for (index, element) in answers.enumerated() {
            answerButtons[index].setTitle(element.removingHTMLEntities, for: .normal)
        }
//        answerButtons[0].setTitle(answers[0].removingHTMLEntities, for: .normal)
//        answerButtons[1].setTitle(answers[1].removingHTMLEntities, for: .normal)
//        answerButtons[2].setTitle(answers[2].removingHTMLEntities, for: .normal)
//        answerButtons[3].setTitle(answers[3].removingHTMLEntities, for: .normal)
        
    }
    
    func nextQuestion(number: Int) {
        self.questionLabel.text = items[number].question.removingHTMLEntities // laat alleen nog eerste vraag zien
        var allAnswers = items[number].incorrectAnswers + [items[number].correctAnswer]
        allAnswers.shuffle()
        self.updateButtons(answers: allAnswers)
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print(sender.title(for: .normal)!)
        if sender.title(for: .normal)! == items[questionCounter].correctAnswer {
            print("CORRECT!")
        } else {
            print("WRONG ANSWER!")
        }
        questionCounter += 1
        nextQuestion(number: questionCounter)
    }
    
    
    
    
    override func viewDidLoad() {
        questionLabel.text = ""
        questionCounter = 0
        for button in answerButtons {
            button.setTitle("", for: .normal)
        }
        
        fetchQuestions()

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

