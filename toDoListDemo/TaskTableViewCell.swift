//
//  TaskTableViewCell.swift
//  toDoListDemo
//
//  Created by Andy Feng on 4/18/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    
    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    // Create the model 
    private var _model: Tasks?
    
    var model: Tasks {
        
        set {
            
            _model = newValue
            
            // do some stuff
            doStuff()
        }
        
        get {
            return _model!
        }
        
        
    }
    
    
    func doStuff() {
        
        titleLabel.text = _model?.title
        descLabel.text = _model?.desc
        
        
        if let d = _model?.date {
            
            // Date
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let myString = formatter.string(from: d as Date)
            dateLabel.text = myString
        }
        
        
        // See if the task is checked. If it's checked then apply the checkmark.
        if (_model?.checked)! {
            
            // this task is checked.
            self.accessoryType = .checkmark
            
        } else {
            
            // this task is un-checked.
            self.accessoryType = .none
        }
        
        

    }
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
