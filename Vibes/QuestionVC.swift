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

    
    var questionCount = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
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

        cell.answerLabel.text = answerArray[questionCount][indexPath.row]

        print(answerArray[questionCount][indexPath.row])
        
        return cell
    }
    

    @IBAction func nextBtn(_ sender: Any) {
        if questionCount < 5 {
            questionCount += 1
            updateQsAndAs(questionCount: questionCount - 1)
        }
    }

    @IBAction func prevBtn(_ sender: Any) {
        if questionCount != 1 {
            questionCount -= 1
            updateQsAndAs(questionCount: questionCount - 1)
        }
    }
    
    func updateQsAndAs(questionCount: Int) {
        questionLabel.text = questionArray[questionCount]
        tableView.reloadData() 
    }
    
}

