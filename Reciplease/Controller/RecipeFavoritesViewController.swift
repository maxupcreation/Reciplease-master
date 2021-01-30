//
//  RecipeFavoritesViewController.swift
//  Reciplease
//
//  Created by Maxime on 13/01/2021.
//  Copyright © 2021 Maxime. All rights reserved.
//

import UIKit

class RecipeFavoritesViewController: UIViewController {
    
    //MARK:- OutLet 🔗
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    //MARK:- Propreties 📦
    var coreDataManager: CoreDataManager?
    
    var favoriteCoreIndex : FavoriteRecipe?
    
    //MARK:- View Cycle ♻️
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //— ❗ Allows to update CoreData
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataManager = CoreDataManager(coreDataStack: appDelegate.coreDataStack)
        
        //X
        
        setupCustomCell()
        
        favoriteTableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteTableView.reloadData()
    }
    
    //MARK:- Override 🧗

    //— 💡 *DataSegues : Passing of data between segues.
    // self -> RecipeDetailsViewController

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipesVC = segue.destination as? RecipeDetailsViewController {
            recipesVC.favoriteCoreIndex = favoriteCoreIndex
        }
    }
}

//MARK:- Extension ↔️

extension RecipeFavoritesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.favorite.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let recipeCell =
            tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)  as? RecipeCelllTableViewCell
        
        
        recipeCell?.configureCoreData(coreDataRecipe:coreDataManager!.favorite[indexPath.row])
        
        
        return recipeCell!
    }
    
    //— 💡 Allows you to assign the custom cell (XIB) to the desired tableView.
    
    private func setupCustomCell() {
        let nib = UINib(nibName: "RecipeCelllTableViewCell", bundle: nil)
        favoriteTableView.register(nib, forCellReuseIdentifier: "tableViewCell")
    }
    
    //X
    
}

//— 💡 Stylish animation to the cell display.

func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let translationMovement = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
    cell.layer.transform = translationMovement
    cell.alpha = 0
    UIView.animate(withDuration: 0.75) {
        cell.layer.transform = CATransform3DIdentity
        cell.alpha = 1
    }
    
    cell.selectionStyle = .none
}

//— 💡 Specifies the height of the cell images

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.frame.height / 2
}

//X

//MARK:- TableView Delegate

extension RecipeFavoritesViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoriteCoreIndex = coreDataManager?.favorite[indexPath.row]
        self.performSegue(withIdentifier: "favoriteRecipeToDetails", sender: (Any).self)
    }
}

//— 💡 Add a text center in tableView if is nil.

extension RecipeFavoritesViewController {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Search for recipes and add them to your favorites by clicking on ⭐️ "
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return coreDataManager?.favorite.isEmpty ?? true ? 450 : 0
    }
}
