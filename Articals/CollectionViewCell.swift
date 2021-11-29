//
//  CollectionViewCell.swift
//  Articals
//
//  Created by Ebtesam Alahmari on 25/11/2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLable: UILabel!
    
    override var isSelected: Bool {
        didSet {
            // set color according to state
            self.backgroundColor = self.isSelected ? UIColor(#colorLiteral(red: 0.3904886842, green: 0.4936468601, blue: 0.5022114515, alpha: 1)) : UIColor(#colorLiteral(red: 0.631372549, green: 0.7882352941, blue: 0.8, alpha: 1))
        }
    }
}
