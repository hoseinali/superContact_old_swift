//
//  HiddenContactCell.swift
//  ContacsDelete
//
//  Created by hosein on 8/19/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit

class HiddenContactCell: UITableViewCell {
    var cellExists:Bool = false
    
    @IBOutlet weak var openView: UIView!
    @IBOutlet weak var stuffView: UIView! {
        didSet {
            stuffView.isHidden = true
            stuffView.alpha = 0
        }
    }
    @IBOutlet weak var tellLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.blue

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func animated(duration:Double, c: @escaping () -> Void) {
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModePaced, animations: {
            self.stuffView.isHidden = !self.stuffView.isHidden
            if self.stuffView.alpha == 1 {
                self.stuffView.alpha = 0.5
            } else {
                self.stuffView.alpha = 1
            }
        }, completion: ({ (finished) in
            print("finish")
        }))
    }
    
}
