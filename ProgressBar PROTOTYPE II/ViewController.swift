//
//  ViewController.swift
//  ProgressBar PROTOTYPE II
//
//  Created by WGonzalez on 1/13/17.
//  Copyright © 2017 Quantum Apple. All rights reserved.
//
//  Wednesday & Thusday
//  Racism

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var progressView: KDCircularProgress!
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var endTurnButton: UIButton!
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var friendlyHealth: UIProgressView!
    @IBOutlet weak var enemyHealth: UIProgressView!
    
    @IBOutlet weak var enemy: UIImageView!
    @IBOutlet weak var friendly: UIImageView!
    
    var timer : Timer?
    var turnTimer : Timer?
    
    var currentProgressFriend = 1.0
    var currentProgressEnemy = 1.0
    var currentCount = 0.0
    let maxCount = 10.0
    var limit = 0.0
    var turn = true
    var attackPower = 0.0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        progressView.angle = 0
        friendlyHealth.transform = friendlyHealth.transform.scaledBy(x: 1, y: 5)
        enemyHealth.transform = enemyHealth.transform.scaledBy(x: 1, y: 5)
        
        friendlyHealth.progress = 1
        enemyHealth.progress = 1
        
        labelOne.text = "3"
        labelTwo.text = "5"
        labelThree.text = "7"
        labelFour.text = "10"
        
        buttonOne.backgroundColor = UIColor.lightGray
        buttonTwo.backgroundColor = UIColor.lightGray
        buttonThree.backgroundColor = UIColor.lightGray
        buttonFour.backgroundColor = UIColor.lightGray
        
        displayLabel.text = "\(currentCount)"
        
        buttonOne.isEnabled = false
        buttonTwo.isEnabled = false
        buttonThree.isEnabled = false
        buttonFour.isEnabled = false
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(moveTheProgressBar), userInfo: nil, repeats: true)
       
    }

    func moveTheProgressBar()
    {
        
        if currentCount != maxCount
        {
            limit += 1
            if limit == maxCount || limit < maxCount
            {
                currentCount += 1
                displayLabel.text = "\(currentCount)"
            }
            let newAngleValue = newAngle()
            
            progressView.animate(toAngle: Double(newAngleValue), duration: 0.5, completion: nil)
            if limit == 10
            {
                timer?.invalidate()
            }
            if limit > 3
            {
                print("Button One is enabled")
                buttonOne.isEnabled = true
                buttonOne.alpha = 1.0
            }
            if limit > 5
            {
                print("Button Two is enabled")
                buttonTwo.isEnabled = true
                buttonTwo.alpha = 1.0
            }
            if limit > 7
            {
                print("Button Three is enabled")
                buttonThree.isEnabled = true
                buttonThree.alpha = 1.0
            }
            if limit == 10
            {
                print("Button Four is enabled")
                buttonFour.isEnabled = true
                buttonFour.alpha = 1.0
            }
        }
        
    }
    func AI() {
        var boolAttacks : [Bool] = [true, true, false, false, false]
        var random = Int(arc4random_uniform(UInt32(boolAttacks.count)))
        var selection = boolAttacks[random]
        print(selection)
        AIAttack()
        for i in 0...1 {
            if selection == true {
                AIAttack()
            } else {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(moveTheProgressBar), userInfo: nil, repeats: true)
                
            }
        }
        
    }
    
    func AIAttack()
    {
        var attack : [Double] = [3.0,5.0,7.0,10.0]
        var random = Int(arc4random_uniform(UInt32(attack.count)))
        var selection = attack[random]
        print(selection)
    }
    
    
    func newAngle() -> Int
    {
        return Int(360 * (currentCount / maxCount))
    }
    
    @IBAction func attackOne(_ sender: Any)
    {
        print("Button One Pressed")
        removeNumber(numberToRemove: 3)
    }
    
    @IBAction func attackTwo(_ sender: Any)
    {
        print("Button Two Pressed")
        removeNumber(numberToRemove: 5)
    }
    
    @IBAction func attackThree(_ sender: Any)
    {
        print("Button Three Pressed")
        removeNumber(numberToRemove: 7)
    }
    
    @IBAction func attackFour(_ sender: Any)
    {
        print("Button Four Pressed")
        removeNumber(numberToRemove: 10)

    }
    @IBAction func endTurn(_ sender: Any)
    {
        print("Turn Ended")
        buttonOne.alpha = 0.5
        buttonTwo.alpha = 0.5
        buttonThree.alpha = 0.5
        buttonFour.alpha = 0.5
        AI()
    }
    
    func removeNumber(numberToRemove : Double)
    {
        let remove = currentCount - numberToRemove
        print(remove)
        if remove > 0 || remove == 0
        {
            currentCount = remove
            displayLabel.text = "\(currentCount)"
            let angleconversion = newAngle()
            progressView.animate(toAngle: Double(angleconversion), duration: 0.5, completion: nil)
        }
    }
    
    
    
}
