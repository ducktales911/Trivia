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
                    self.questionLabel.text = items[0].question.removingHTMLEntities // laat alleen nog eerste vraag zien
                    var allAnswers = items[0].incorrectAnswers + [items[0].correctAnswer]
                    allAnswers.shuffle()
                    self.updateButtons(answers: allAnswers)
                } else {
                    print("Unable to load data.")
                }
            }
        })
    }
    
    func updateButtons(answers: [String]) {
        answerButtons[0].setTitle(answers[0].removingHTMLEntities, for: .normal)
        answerButtons[1].setTitle(answers[1].removingHTMLEntities, for: .normal)
        answerButtons[2].setTitle(answers[2].removingHTMLEntities, for: .normal)
        answerButtons[3].setTitle(answers[3].removingHTMLEntities, for: .normal)
        
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print(sender.title(for: .normal)!)
    }
    
    
    
    
    override func viewDidLoad() {
        questionLabel.text = ""
        for button in answerButtons {
            button.setTitle("", for: .normal)
        }
        
        fetchQuestions()

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

