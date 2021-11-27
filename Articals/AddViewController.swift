//
//  AddViewController.swift
//  Articals
//
//  Created by Ebtesam Alahmari on 25/11/2021.
//

import UIKit

class AddViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var categoryArr = ["Sport","Nature","Beauty","Technology"]
    var categorySelected = ""
    var articels:[Article] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var contentTxt: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func save(_ sender: Any) {
        var newArticle = Article(context: self.context)
        newArticle.name = titleTxt.text
        newArticle.details = contentTxt.text
        newArticle.category = categorySelected
        newArticle.creationDate = Date.now
        articels.append(newArticle)
        saveData()
        navigationController?.popViewController(animated: true)
    }
    
    func saveData() {
        do {
            try context.save()
        }catch {
            print(error)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CollectionViewCell
        cell.categoryLable.text =  categoryArr[indexPath.row]
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categorySelected = categoryArr[indexPath.row]
    }
    
}
