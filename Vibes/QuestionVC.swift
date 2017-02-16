//
//  QuestionVC.swift
//  Vibes
//
//  Created by Benjamin Katz on 2/7/17.
//  Copyright © 2017 Benjamin Katz. All rights reserved.
//

import UIKit

class QuestionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!

    var questionCount = 0
    // Array to hold user's answers to calculate the results
    var resultsArray: [[String]]!
    
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
        return answerArray[questionCount].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! AnswerCell

        if questionCount == 1 {
            tableView.allowsMultipleSelection = true
        } else {
            tableView.allowsMultipleSelection = false
        }
        
        cell.answerLabel.text = answerArray[questionCount][indexPath.row]

        return cell
    }
    
    // Button Functions also reponsible for updating questionCount
    // as well as checking to see if they should be enabled/disabled
    @IBAction func nextBtn(_ sender: Any) {
        if questionCount < 5 {
            questionCount += 1
            updateQsAndAs(questionCount: questionCount)
            enableButtons(questionCount: questionCount)
        }
    }

    @IBAction func prevBtn(_ sender: Any) {
        if questionCount > 0 {
            questionCount -= 1
            updateQsAndAs(questionCount: questionCount)
            enableButtons(questionCount: questionCount)
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
    
}

