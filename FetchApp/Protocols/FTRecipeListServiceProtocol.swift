//
//  FTRecipeListServiceProtocol.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import Foundation

protocol FTRecipeListServiceProtocol {
  func fetchRecipes(completion: @escaping (Result<[FTRecipe], FTError>) -> Void)
}
