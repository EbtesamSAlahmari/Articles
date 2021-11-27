//
//  ShowViewController.swift
//  Articals
//
//  Created by Ebtesam Alahmari on 25/11/2021.
//

import UIKit

class ShowViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var contentView: UITextView!
    
    var articels:Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = articels!.name
        categoryLbl.text = articels!.category
        contentView.text = articels!.details
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        dateLbl.text = dateFormatter.string(from: articels!.creationDate!)
    }
    
}

