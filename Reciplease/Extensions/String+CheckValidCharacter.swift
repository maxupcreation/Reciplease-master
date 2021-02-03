//
//  String+CheckValidCharacter.swift
//  Reciplease
//
//  Created by Maxime on 03/02/2021.
//

import Foundation

//— 💡 Text control in the textField to add ingredients

extension String {
    
    var containsValidCharacter: Bool {
        guard self != "" else { return true }
        let hexSet = CharacterSet(charactersIn: "abdcdefghijklmnopqrstuvwxyz")
        let newSet = CharacterSet(charactersIn: self)
        return hexSet.isSuperset(of: newSet)
    }
}
