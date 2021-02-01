
import UIKit

// MARK: - Welcome
struct RecipeSearchDataStruct: Decodable {
    let q: String
    let from, to: Int
    let more: Bool
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipe
    //  let bookmarked, bought: Bool
}

// MARK: - Recipe
struct Recipe: Decodable {
    
    //Titre de la recette
    let label: String
    
    //URL de l'image
    let image: String?
    
    //URL de la recette originale
    let url: String
    
    //Portions
    let yield: Int
    
    //liste d'ingrédient
    let ingredients: [Ingredient]
    
    //temps de préparation
    let totalTime: Int?
    
    let calories : Float
    
    // MARK: - Ingredient
    struct Ingredient: Decodable {
        let text: String
        let weight: Double
        let image: String?
    }
}
