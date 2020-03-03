//
//  EntryCellTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Sean Jones on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

protocol EntryCellTableViewCellDelegate: class{
    func switchToggledOn(cell:EntryCellTableViewCell)
    
}

class EntryCellTableViewCell: UITableViewCell {

    // MARK: OUTLETS
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var higerOrLowerLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    //MARK: PROPERTIES
    
    var entry: Entry?
    weak var delegate: EntryCellTableViewCellDelegate?
    
    //MARK: HELPER FUNCTIONS
    
    func setEntry(entry:Entry, averageHappiness: Int){
        self.entry = entry
        updateUI(averageHappiness: averageHappiness)
        
    }
    
    func updateUI(averageHappiness: Int){
        guard let entry = entry else {return}
        titleLabel.text = entry.title
        isEnabledSwitch.isOn = entry.isIncluded
        
        higerOrLowerLabel.text = entry.happiness >= averageHappiness ? "higher" : "lower"
        
        //update higher or lower after notifications
    }
    
    @IBAction func toggledIsIncluded(_ sender: Any) {
        delegate?.switchToggledOn(cell: self)
    }
    
}
