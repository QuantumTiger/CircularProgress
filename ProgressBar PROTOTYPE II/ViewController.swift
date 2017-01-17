//
//  ViewController.swift
//  ProgressBar PROTOTYPE II
//
//  Created by WGonzalez on 1/13/17.
//  Copyright © 2017 Quantum Apple. All rights reserved.
//

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
    
    var currentCount = 0.0
    let maxCount = 10.0
    var limit = 0.0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        progressView.angle = 0
        friendlyHealth.transform = friendlyHealth.transform.scaledBy(x: 1, y: 5)
        enemyHealth.transform = enemyHealth.transform.scaledBy(x: 1, y: 5)
        
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
                buttonOne.backgroundColor = UIColor.cyan
            }
            if limit > 5
            {
                print("Button Two is enabled")
                buttonTwo.isEnabled = true
                buttonTwo.backgroundColor = UIColor.purple
            }
            if limit > 7
            {
                print("Button Three is enabled")
                buttonThree.isEnabled = true
                buttonThree.backgroundColor = UIColor.green
            }
            if limit == 10
            {
                print("Button Four is enabled")
                buttonFour.isEnabled = true
                buttonFour.backgroundColor = UIColor.magenta
            }
        }
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
        buttonOne.backgroundColor = UIColor.lightGray
        buttonTwo.backgroundColor = UIColor.lightGray
        buttonThree.backgroundColor = UIColor.lightGray
        buttonFour.backgroundColor = UIColor.lightGray
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
