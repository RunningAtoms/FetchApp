//
//  FTRecipeList.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import Foundation

struct FTRecipeList: FTBaseModel, Codable {
  var recipes: [FTRecipe]
}
