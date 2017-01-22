//
//  ViewController.swift
//  ProgressBar PROTOTYPE II
//
//  Created by WGonzalez on 1/13/17.
//  Copyright © 2017 Quantum Apple. All rights reserved.
//
//  Wednesday & Thusday
//  

import UIKit

class ViewController: UIViewController
{
    
    //outlets from the storyboard
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
    
    //timers
    var timer : Timer?
    var turnTimer : Timer?
    
    //variables
    var currentProgressFriend = 1.0
    var currentProgressEnemy = 1.0
    var FriendAttackPower = 0.0
    var currentCount = 0.0
    let maxCount = 10.0
    var limit = 0.0
    var limitTwo = 0.0
    var turn = true
    var attackPower = 0.0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        progressView.angle = 0
        friendlyHealth.transform = friendlyHealth.transform.scaledBy(x: 1, y: 5)
        enemyHealth.transform = enemyHealth.transform.scaledBy(x: 1, y: 5)
        
        //sets the progress of the progress view
        friendlyHealth.progress = 1
        enemyHealth.progress = 1
        
        //sets the text of the labels
        labelOne.text = "3"
        labelTwo.text = "5"
        labelThree.text = "7"
        labelFour.text = "10"
        
        displayLabel.text = "\(currentCount)"
        
        //can't tap the button
        buttonOne.isEnabled = false
        buttonTwo.isEnabled = false
        buttonThree.isEnabled = false
        buttonFour.isEnabled = false
        
        //timer that allows the progress bar to move and keep track on the game
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(moveTheProgressBar), userInfo: nil, repeats: true)
       
    }

    func moveTheProgressBar()
    {
        
        if currentCount != maxCount && limitTwo != 5.0
        {
            limit += 1.0
            limitTwo += 1.0
            //90 -> 95 : Creates a cap so the progress bar does not go beyond its set limit
            if limit == maxCount || limit < maxCount
            {
                currentCount += 1.0
                displayLabel.text = "\(currentCount)"
            }
            
            let newAngleValue = newAngle()
            
            progressView.animate(toAngle: Double(newAngleValue), duration: 0.5, completion: nil)
            // 100 -> 149 : Enables the buttons over time
            if limit >= 3.0
            {
                
                buttonOne.isEnabled = true
                buttonOne.alpha = 1.0
            }
            else
            {
                buttonOne.isEnabled = false
                buttonOne.alpha = 0.5

            }
            
            if limit >= 5.0
            {
                
                buttonTwo.isEnabled = true
                buttonTwo.alpha = 1.0
            }
            else
            {
                buttonTwo.isEnabled = false
                buttonTwo.alpha = 0.5
            }
            
            if limit >= 7.0
            {
               
                buttonThree.isEnabled = true
                buttonThree.alpha = 1.0
            }
            else
            {
                buttonThree.isEnabled = false
                buttonThree.alpha = 0.5

            }
            
            if limit >= 10.0
            {
                
                buttonFour.isEnabled = true
                buttonFour.alpha = 1.0
            }
            else
            {
                buttonFour.isEnabled = false
                buttonFour.alpha = 0.5
            }
        }
        
    }
    
    //The AI which is the red block and how he attacks
    func AI()
    {
        //an array of bools
        var boolAttacks : [Bool] = [true, true, false, false, false]
        //pulls a random bool from the array
        var random = Int(arc4random_uniform(UInt32(boolAttacks.count)))
        //picks one of the bools
        var selection = boolAttacks[random]
        
        //func for attacking
        AIAttack()
        
        //runs a loop to see if the arc for random pulled true to see if it gets to attack again
        for i in 0...1
        {
            
            if selection == true
            {
                AIAttack()

            }
        }
    }
    
    
    //the func on how the AI Attacks
    func AIAttack()
    {
        
        //choses one number from the array
        var attack : [Double] = [3.0, 3.0, 3.0, 3.0, 5.0, 5.0, 5.0, 7.0, 7.0, 10.0]
        var random = Int(arc4random_uniform(UInt32(attack.count)))
        var selection = attack[random]
        
        //depending on the number it deals out the damage given
        if selection == 3.0
        {
            damageFriend(Damage: 0.05)
        }
            
        else if selection == 5.0
        {
            damageFriend(Damage: 0.1)
            
        }
            
        else if selection == 7.0
        {
            damageFriend(Damage: 0.25)
            
        }
            
        else if selection == 10.0
        {
            
            damageFriend(Damage: 0.4)
        }
        
    }
    
    //the func that decreases the progress view
    func damageFriend(Damage: Double)
    {
        //subtracts from the progressview
        currentProgressFriend -= Damage
        //sets the new values of the progress view
        friendlyHealth.setProgress(Float(currentProgressFriend), animated: true)
    }
    
    func newAngle() -> Int
    {
        return Int(360 * (currentCount / maxCount))
    }
    
    // 229 -> 260 : Each button removes points from the total value, runs a function to set the angle of the circle
    @IBAction func attackOne(_ sender: Any)
    {
        
        removeNumber(numberToRemove: 3)
        //sets the attack power of the Friend
        FriendAttackPower += 0.05
    }
    
    @IBAction func attackTwo(_ sender: Any)
    {
        
        removeNumber(numberToRemove: 5)
        FriendAttackPower += 0.1
        
    }
    
    @IBAction func attackThree(_ sender: Any)
    {
        
        removeNumber(numberToRemove: 7)
        FriendAttackPower += 0.25
    }
    
    @IBAction func attackFour(_ sender: Any)
    {
        
        removeNumber(numberToRemove: 10)
        FriendAttackPower += 0.4
        
    }
    
    //does the same thing as damaging the friend
    func damageEnemy(Damage: Double)
    {
        currentProgressEnemy -= Damage
        enemyHealth.setProgress(Float(currentProgressEnemy), animated: true)
    }
    
    @IBAction func endTurn(_ sender: Any)
    {
        print("Turn Ended")
        limitTwo = 0.0
        buttonOne.alpha = 0.5
        buttonTwo.alpha = 0.5
        buttonThree.alpha = 0.5
        buttonFour.alpha = 0.5
        damageEnemy(Damage: FriendAttackPower)
        FriendAttackPower = 0.0
        limit = currentCount
        AI()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(moveTheProgressBar), userInfo: nil, repeats: true)
    }
    
    func removeNumber(numberToRemove : Double)
    {
        let remove = currentCount - numberToRemove
        // 287 -> 294 : If statement that checks if there is enough points to remove from and sets the angle of the progress bar
        if remove > 0 || remove == 0
        {
            currentCount = remove
            displayLabel.text = "\(currentCount)"
            let angleconversion = newAngle()
            progressView.animate(toAngle: Double(angleconversion), duration: 0.5, completion: nil)
        }
        // 295 -> 318 : If statement that sets the alpha to 0.5 when there isn't enough points to spend for the button
        if 3 > remove
        {
            buttonOne.alpha = 0.5
        }
        if 5 > remove
        {
            buttonTwo.alpha = 0.5
        }
        if 7 > remove
        {
            buttonThree.alpha = 0.5
        }
        if 10 > remove
        {
            buttonFour.alpha = 0.5
        }
        if remove == 0
        {
            buttonOne.alpha = 0.5
            buttonTwo.alpha = 0.5
            buttonThree.alpha = 0.5
            buttonFour.alpha = 0.5
        }
    }
    
    
    
}
