//
//  ResultsViewController.swift
//  Personal Quiz
//
//  Created by Valerii D on 25.04.2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    //MARK: IB Outlets
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    //MARK: - Public properties
    var responses: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        updateResult()
    }
    
    private func updateResult() {
        var frequencyOfAnimal: [AnimalType : Int] = [ : ]
        let animals = responses.map { $0.type }
        
        
        for animal in animals {
            frequencyOfAnimal[animal] = (frequencyOfAnimal[animal] ?? 0) + 1
        }
        
        let sortedFrequencyOfAnimal = frequencyOfAnimal.sorted { $0.value > $1.value }
        
        guard let mostFrequencyAnimal = sortedFrequencyOfAnimal.first?.key else { return }
        
        updateUI(with: mostFrequencyAnimal)
    }
    
    private func updateUI(with animal: AnimalType) {
        resultAnswerLabel.text = "Вы - \(animal.rawValue)!"
        resultDefinitionLabel.text = "\(animal.definition)"
    }
    
    
    
}
