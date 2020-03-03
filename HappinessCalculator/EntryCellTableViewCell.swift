//
//  EntryCellTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Sean Jones on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

//Declaring a protocol and allowing it to use class elvel object
protocol EntryCellTableViewCellDelegate: class{
    //creating a job  the Boss, TableView Cell, is telling the intern, TableListViewController to do
    func switchToggledOn(cell:EntryCellTableViewCell)
    
}

class EntryCellTableViewCell: UITableViewCell {

    // MARK: OUTLETS
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var higerOrLowerLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    //MARK: PROPERTIES
    
    var entry: Entry?
    
    // creating our Runner
    weak var delegate: EntryCellTableViewCellDelegate?
    
    //MARK: HELPER FUNCTIONS
    
    func setEntry(entry:Entry, averageHappiness: Int){
        self.entry = entry
        updateUI(averageHappiness: averageHappiness)
        
    }
    
    @objc func updateUI(averageHappiness: Int){
        guard let entry = entry else {return}
        titleLabel.text = entry.title
        isEnabledSwitch.isOn = entry.isIncluded
        
        higerOrLowerLabel.text = entry.happiness >= averageHappiness ? "higher" : "lower"
        
        //update higher or lower after notifications
    }
    
   @objc func createObserver(){
    //creating our Person who wil listen for our notification, the call recalculate happiness
        NotificationCenter.default.addObserver(self, selector: #selector(recalculateHappiness), name: notificationKey, object: nil)
    }
    
    @objc func recalculateHappiness(notification: NSNotification){
        guard let averageHappiness = notification.object as? Int else{return}
        updateUI(averageHappiness: averageHappiness)
        
        
        
    }
    
    @IBAction func toggledIsIncluded(_ sender: Any) {
        // telling our runner to go tell pur intern to do something
        delegate?.switchToggledOn(cell: self)
    }
    
}
