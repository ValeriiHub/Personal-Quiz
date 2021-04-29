//
//  QuestionViewController.swift
//  Personal Quiz
//
//  Created by Valerii D on 25.04.2021.
//

import UIKit

class QuestionViewController: UIViewController {
    
    //MARK: - IB Outlrts
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singlebuttons: [UIButton]!

    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multipleLables: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet var rangedLables: [UILabel]!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    //MARK: - Private Properties
    
    private let questions = Questions.getQuestion()
    private var questionIndex = 0
    private var answerChoosen: [Answer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: IB Actions
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        guard let currentIndex = singlebuttons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[currentIndex]
        answerChoosen.append(currentAnswer)
        
        nextQuestion()
    }
    
    @IBAction func multipleAnsweerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answerChoosen.append(answer)
            }
        }
        
        nextQuestion()
    }
    
    
    @IBAction func rangedAnswersButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answerChoosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    
    //MARK: Private Methods
    
    // Update UI
    private func updateUI() {
        // Hide everithing
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        
        //Get current question
        let currentQuestion = questions[questionIndex]
        print(currentQuestion)
        // Set current question for question label
        questionLabel.text = currentQuestion.text
        
        // Calculate progress
        let totalProgres = Float(questionIndex) / Float(questions.count)
        
        // Set progress for question progress view
        questionProgressView.setProgress(totalProgres, animated: true)
        
        // Set navigation title
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        let currentAnswers = currentQuestion.answers
        
        // Show stack view corresponding to question type
        switch currentQuestion.type {
        case .single:
            updateSingleStackViev(using: currentAnswers)
        case .multiple:
            updateMultipleStackViev(using: currentAnswers)
        case .ranged:
            updateRangedStackViev(using: currentAnswers)
        }

        
        
    }
    
    /// Setup single stack view
    /// - Parameter using: - array with answers
    ///
    /// Description of method
    private func updateSingleStackViev(using answers: [Answer]) {
        // Show single stack view
        singleStackView.isHidden = false
        
        for (button, answer) in zip(singlebuttons, answers) {
            button.setTitle(answer.text, for: .normal)
        }
    }
    
    private func updateMultipleStackViev(using answers: [Answer]) {
        // Show multiple stack view
        multipleStackView.isHidden = false
        
        for (label, answer) in zip(multipleLables, answers) {
            label.text = answer.text
        }
    }
    
    private func updateRangedStackViev(using answers: [Answer]) {
        // Show ranged stack view
        rangedStackView.isHidden = false
        
        rangedLables.first?.text = answers.first?.text
        rangedLables.last?.text = answers.last?.text
    }
    
    //MARK: - Navigation
    // Show next question or go to the next screen
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "resultSegue", sender: nil)
        }
        
    } 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "resultSegue" else { return }
        let resultVC = segue.destination as! ResultsViewController
        resultVC.responses = answerChoosen
    }
}
