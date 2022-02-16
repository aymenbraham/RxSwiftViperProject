//
//  HomeTableViewCell.swift
//  ViperRxSwiftFirstApp
//
//  Created by aymen braham on 15/02/2022.
//

import UIKit

protocol CellOutput: AnyObject {
    func buttonClicked(sender: AnyObject)
}

class HomeTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var buttonOrder: UIButton!
    
    // MARK: Variables
    weak var delegate: CellOutput?
    
    // MARK: LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buttonOrder.setBackgroundColor(color: .black, forState: .normal)
        buttonOrder.setBackgroundColor(color: .systemGreen, forState: .highlighted)
        buttonOrder.setTitle("added + 1", for: .highlighted)
        buttonOrder.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: User Interaction
    @objc func buttonClicked(sender: AnyObject) {
        delegate?.buttonClicked(sender: self)
    }
}
