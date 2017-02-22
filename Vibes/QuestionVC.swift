//
//  QuestionVC.swift
//  Vibes
//
//  Created by Benjamin Katz on 2/7/17.
//  Copyright © 2017 Benjamin Katz. All rights reserved.
//

import UIKit

/// Send any data to the QuestionController for any actions to take place
/// on the data 
class QuestionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    
//    var questionController: QuestionController!

    var questionCount = 0
    
    // Object to hold user's answers to calculate the results
    var answerObj = Establishment()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        prevBtn.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qAnswerArray[questionCount].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        print("fuck")

        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! AnswerCell

        if questionCount == 1 {
            tableView.allowsMultipleSelection = true
        } else {
            tableView.allowsMultipleSelection = false
        }
        
        cell.answerLabel.text = qAnswerArray[questionCount][indexPath.row]

        return cell
    }
    
    // If row (answer) selected add to answerArray
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get answer text using indexpath
        let text = qAnswerArray[questionCount][indexPath.row]
        // Update answerObj
        updateAnswers(questionCount: questionCount, answer: text, deselect: false)
        //     questionController.updateAnswers(text)
    
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // Get answer text
        let text = qAnswerArray[questionCount][indexPath.row]
        // Update answerObj
        updateAnswers(questionCount: questionCount, answer: text, deselect: true)
        
    }
    
    // Button Functions also reponsible for updating questionCount
    // as well as checking to see if they should be enabled/disabled
    @IBAction func nextBtn(_ sender: Any) {
        if questionCount < 5 {
            questionCount += 1
            updateQsAndAs(questionCount: questionCount)
            enableButtons(questionCount: questionCount)
            
            // Must add delay timer otherwise cellForRowAt rewrites cell
            // because I "create" the cells again. But am not sure how to 
            // access the custom cell without using dequeuResuableCell
            let when = DispatchTime.now() + 0.01
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.updateSelection(questionCount: self.questionCount)
            }
        }
    }

    @IBAction func prevBtn(_ sender: Any) {
        if questionCount > 0 {
            questionCount -= 1
            updateQsAndAs(questionCount: questionCount)
            enableButtons(questionCount: questionCount)
            
            // See message in nextBtn func for what this code is and why
            let when = DispatchTime.now() + 0.01
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.updateSelection(questionCount: self.questionCount)
            }
        }
    }
    
    
    // Helper Functions ------------------------------------------------------
    
    // Func to update the Question based on questionCount 
    // and calls to reload the tableView data to update the answers
    func updateQsAndAs(questionCount: Int) {
        questionLabel.text = questionArray[questionCount]
        tableView.reloadData()
    }
    
    // Func to check if buttons should be enabled/disabled
    func enableButtons(questionCount: Int) {
        if questionCount == 0 {
            prevBtn.isEnabled = false
        } else {
            prevBtn.isEnabled = true
        }
        
        if questionCount == 4 {
            nextBtn.isEnabled = false
        } else {
            nextBtn.isEnabled = true
        }
    }
    
    // Helper func to make sure tableView has correct rows selected
    // when using previous/next buttons
    //   Current Problem: selectRow requires IndexPath which I'm not sure
    //   of the best way of how to get that based how I have the table
    //   reloading. Will come back too
    func updateSelection(questionCount: Int) {
        if questionCount == 0 {
            if answerObj.vibe != "" {
                let index = qAnswerArray[questionCount].index(of: answerObj.vibe)
                selectRow(index: index!, multiSelection: false)
            }
        } else if questionCount == 1 {
            if answerObj.venue != [] {
                let index = 0
                selectRow(index: index, multiSelection: true)
            }
        } else if questionCount == 2 {
            var index = 0
            if answerObj.food == false {
                index = 1
            }
            selectRow(index: index, multiSelection: false)
        } else if questionCount == 3 {
            if answerObj.price != "" {
                let index = qAnswerArray[questionCount].index(of: answerObj.price)
                selectRow(index: index!, multiSelection: false)
            }
        } else if questionCount == 4 {
            if answerObj.location != 0 {
                let index = 0
                selectRow(index: index, multiSelection: false)
            }
        }
    }
    
    // Helper function for updateSelection to reuse code
    func selectRow(index: Int, multiSelection: Bool) {
        if multiSelection == false {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
            
        // Else rows == True which means it is a multiselection question
        // For now we know that must be question 2 (venues)
        } else {
            for venue in answerObj.venue {
                let index = qAnswerArray[questionCount].index(of: venue)
                let indexPath = IndexPath(row: index!, section: 0)
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
            }
        }
    }
    
    // Helper func to update the AnswerObj for the results screen
    func updateAnswers(questionCount: Int, answer: String, deselect: Bool) {
        if deselect == false {
            if questionCount == 0 {
                answerObj.vibe = answer
            } else if questionCount == 1 {
                if !answerObj.venue.contains(answer) {
                    answerObj.venue.append(answer)
                }
            } else if questionCount == 2 {
                if answer == "Yes" {
                    answerObj.food = true
                } else {
                    answerObj.food = false
                }
            } else if questionCount == 3 {
                answerObj.price = answer
            } else if questionCount == 4 {
                answerObj.location = 5
            } else {
                print("Error questionCount out of bounds (>4)")
            }
            
        // Only allowing Deselection on multiselection
        } else {
            if questionCount == 1 {
                if answerObj.venue.contains(answer) {
                    let index = answerObj.venue.index(of: answer)
                    answerObj.venue.remove(at: index!)
                }
            }
        }
        
        answerObj.printObj()
    }
    
}
