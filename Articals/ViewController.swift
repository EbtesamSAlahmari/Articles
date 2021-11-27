//
//  ViewController.swift
//  Articals
//
//  Created by Ebtesam Alahmari on 25/11/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController  {
    
    var articels:[Article] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedArticels:Article?
    var categoryArr = ["All","Sport","Nature","Beauty","Technology"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        do {
            articels = try context.fetch(request)
        }catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    func saveData() {
        do {
            try context.save()
            tableView.reloadData()
        }catch {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            let nextVC = segue.destination as! ShowViewController
            nextVC.articels = selectedArticels!
        }
    }
}


//MARK: -UITableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ArticleCell
        cell.titleLable.text = articels[indexPath.row].name
        cell.categoryLable.text = articels[indexPath.row].category
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticels = articels[indexPath.row]
        performSegue(withIdentifier: "show", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(articels[indexPath.row])
            articels.remove(at: indexPath.row)
            self.saveData()
        }
    }
}

//MARK: -UICollectionView
extension ViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CategoryCell
        cell.categoryLbl.text =  categoryArr[indexPath.row]
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if categoryArr[indexPath.row] == "All"{
            loadData()
        }else {
            let request = Article.fetchRequest()
            request.predicate = NSPredicate(format: "category == %@ ", categoryArr[indexPath.row])
            request.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            
            do {
                articels =  try context.fetch(request)
            }catch {
                print("Error")
            }
            tableView.reloadData()
        }
    }
    
    
}
