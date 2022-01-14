//
//  ViewController.swift
//  BeWary?
//
//  Created by Sebastian Lopez on 12/18/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        healthConditionPicker.delegate = self
        healthConditionPicker.dataSource = self
        vaxStatPicker.delegate = self
        vaxStatPicker.dataSource = self
        locationPicker.delegate = self
        locationPicker.dataSource = self
        */
    }
    
    @IBOutlet weak var ageInput: UITextField!
    @IBOutlet weak var healthConditionPicker: UIPickerView!
    @IBOutlet weak var vaxStatPicker: UIPickerView!
    @IBOutlet weak var locationPicker: UIPickerView!
    @IBOutlet weak var recentTravelToggle: UISwitch!
    @IBOutlet weak var maskUseToggle: UISwitch!
    @IBOutlet weak var socialDistancingToggle: UISwitch!
    @IBOutlet weak var handWashingToggle: UISwitch!
    
    var healthConditionOptions = ["none", "cancer", "chronic liver disease", "chronic lung disease", "sicke cell disease", "neurological condition", "learning disability", "HIV or AIDS", "weakened immune system", "pregnancy", "tuberculosis", "cerebrovascular disease", "respiratory or lung problems", "mental health conditions", "chronic kidney disease", "heart conditions or circulation problems", "diabetes", "obesity", "essential hypertension or high blood pressure"]
    
    var vaccinationStatusOptions = ["2 dose with Moderna booster", "2 dose with Pfizer booster", "two dose only (Pfizer or Moderna)", "JnJ, Sinopharm, or Astrazeneca", "none"]
    
    var ICR = 0.0
    var HCR = 0.0 //temporal variables
    var DCR = 0.0
    
    func ICRforAge() -> Double{
        var ICR: Double
        let age = ageInput.text!
        let conv = Int(age) ?? 0
        
        if conv > 0 && conv <= 4{
            ICR = 3
        }else if conv >= 5 && conv <= 85{
            ICR = 5
        }else{
            ICR = 7
        }
        return ICR
    }
    func HCRforAge() -> Double{
        var HCR: Double
        let age = ageInput.text!
        let conv = Int(age) ?? 0
        
        if conv >= 0 && conv <= 17{
            HCR = 3
        }else if conv >= 18 && conv <= 29{
            HCR = 5
        }else if conv >= 30 && conv <= 49{
            HCR = 6
        }else if conv >= 50 && conv <= 64{
            HCR = 6.5
        }else if conv >= 65 && conv <= 74{
            HCR = 7
        }else if conv >= 75 && conv <= 84{
            HCR = 7.8
        }else{
            HCR = 8.2
        }
        return HCR
    }
    func DCRforAge() -> Double{
        var DCR: Double
        let age = ageInput.text!
        let conv = Int(age) ?? 0
        
        if conv >= 0 && conv <= 17{
            DCR = 3
        }else if conv >= 18 && conv <= 29{
            DCR = 5
        }else if conv >= 30 && conv <= 39{
            DCR = 6.5
        }else if conv >= 40 && conv <= 49{
            DCR = 8
        }else if conv >= 50 && conv <= 64{
            DCR = 8.5
        }else if conv >= 65 && conv <= 74{
            DCR = 9
        }else{
            DCR = 9.7
        }
        return DCR
    }
    func totalAgeConcern() -> Double{
        //figure out how to get ICR HCR DCR to work with the calculations below
        let ageScore = (ICR+HCR+DCR) / 3.0
        return ageScore * 0.1
    }
    
    func vaccinationStatus() -> Double{
        let selectedVax = "none" //temporal variable
        var vaxScore: Double
        
        if selectedVax == "2 dose with Moderna booster"{
            vaxScore = 1.0
        }else if selectedVax == "2 dose with Pfizer booster"{
            vaxScore = 2.0
        }else if selectedVax == "two dose only (Pfizer or Moderna)"{
            vaxScore = 5.0
        }else if selectedVax == "JnJ, Sinopharm, Astrazeneca"{
            vaxScore = 8.0
        }else{
            vaxScore = 8.5
        }
        return vaxScore * 0.45
    }
    
    func healthConditionConcern() -> Double{
        let selectedHealth = "none"
        var healthConditionScore: Double
        
        let scoreThreeList = ["cancer", "chronic liver disease", "chronic lung disease", "sicke cell disease", "neurological condition", "learning disability", "HIV or AIDS", "weakened immune system", "pregnancy", "tuberculosis", "cerebrovascular disease"]
        if selectedHealth == "none"{
            healthConditionScore = 0.0
        }else if scoreThreeList.contains(selectedHealth){
            healthConditionScore = 3.0
        }else if selectedHealth == "respiratory or lung problems"{
            healthConditionScore = 4.0
        }else if selectedHealth == "mental health conditions"{
            healthConditionScore = 4.5
        }else if selectedHealth == "chronic kidney disease"{
            healthConditionScore = 5.0
        }else if selectedHealth == "heart conditions or circulation problems"{
            healthConditionScore = 5.0
        }else if selectedHealth == "diabetes"{
            healthConditionScore = 5.5
        }else if selectedHealth == "obesity"{
            healthConditionScore = 6.0
        }else{
            healthConditionScore = 8.0
        }
        return healthConditionScore * 0.3
    }
    
    func miscellaneousConcern() -> Double{
        var travelScore: Double
        var socialDistancingScore: Double
        var handWashingScore: Double
        var maskUseScore: Double
        
        if recentTravelToggle.isOn{
            travelScore = 1.0
        }else{
            travelScore = 0.0
        }
        if socialDistancingToggle.isOn{
            socialDistancingScore = 0.0
        }else{
            socialDistancingScore = 2.0
        }
        if handWashingToggle.isOn{
            handWashingScore = 0.0
        }else{
            handWashingScore = 3.0
        }
        if maskUseToggle.isOn{
            maskUseScore = 0.0
        }else{
            maskUseScore = 5.0
        }
        return travelScore + socialDistancingScore + handWashingScore + maskUseScore
    }
}

