//
//  CategoryCollectionViewCell.swift
//  ViperRxSwiftFirstApp
//
//  Created by aymen braham on 15/02/2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!

    func setSelected(_ selected: Bool, animated: Bool) {
       if (selected) {
           self.title.textColor = UIColor.black
       } else {
           self.title.textColor = UIColor.lightGray
       }
   }
}
