//
//  RecipeCelllTableViewCell.swift
//  Reciplease
//
//  Created by Maxime on 08/01/2021.
//  Copyright © 2021 Maxime. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeCelllTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var calorieLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func configure(dataRecipe: Recipe) {
        
        let title = dataRecipe.label
        
        
        //— 💡 Calorie Formated
        
        let calorie = dataRecipe.calories
        let formated = String(format: "%.1f cal", calorie)
        calorieLabel.text = formated
        
        //X
        
        let time = dataRecipe.totalTime ?? 0
        
        titleLabel.text = title
        
        
        ingredientsLabel.text = dataRecipe.ingredients.first?.text
        
        //X
        
        timeLabel.text = String(time) + " min"
        
        //— 💡 Load Image
        
        let recipeImage = dataRecipe.image ?? "default"
        recipeImageView.sd_setImage(with: URL(string:recipeImage))
        
        //X
    }
    
    func configureCoreData(coreDataRecipe: FavoriteRecipe) {
        
        titleLabel.text = coreDataRecipe.label
        timeLabel.text = coreDataRecipe.totalTime
        
        ingredientsLabel.text = coreDataRecipe.ingredients![0]
        calorieLabel.text = coreDataRecipe.calories
        
        let imageDefaultData = UIImage(imageLiteralResourceName: "default").pngData()
        
        recipeImageView.image = UIImage(data: coreDataRecipe.image ?? imageDefaultData!)
        recipeImageView.contentMode = .scaleAspectFill
        
    }
}
