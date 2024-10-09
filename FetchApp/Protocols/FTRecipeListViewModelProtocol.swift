//
//  FTRecipeListViewModelProtocol.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import Foundation

protocol FTRecipeListViewModelProtocol {
  var numberOfRecipes: Int { get }
  var delegate: FTRecipeListViewModelDelegate? { get set }
  var sortOrder: FTRecipeListSortOrder { get set }

  func fetchRecipes()
  func recipe(at index: Int) -> FTRecipe
  func getError() -> FTError?
  func showEmptyState() -> Bool
  func filterRecipes(searchText: String)
  func sortBy(sortOrder: FTRecipeListSortOrder)
}

enum FTRecipeListSortOrder: CustomStringConvertible, CaseIterable {

  case none
  case nameAscending
  case nameDescending

  var description: String {
    switch self {
      case .none:
        return "No Sorting (Default Server Order)"
      case .nameAscending:
        return "Sort by recipe name ascending(A-Z)"
      case .nameDescending:
        return "Sort by recipe name descending(Z-A)"
    }
  }

  func getButtonTitle() -> String {
    switch self {
      case .none:
        return "Sort Selection: No sorting (default server order)"
      case .nameAscending:
        return "Sort Selection: Recipe name (Ascending)"
      case .nameDescending:
        return "Sort Selection: Recipe name (Descending)"
    }
  }

}
