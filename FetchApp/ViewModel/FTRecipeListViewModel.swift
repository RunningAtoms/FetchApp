//
//  FTRecipeListViewModel.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import Foundation

protocol FTRecipeListViewModelDelegate: AnyObject {
  func didUpdateRecipeList()
  func didFailWithError(_ error: FTError)
}

class FTRecipeListViewModel: FTRecipeListViewModelProtocol, FTBaseViewModel {

  private let recipeListServiceImpl: FTRecipeListServiceProtocol
  private var allRecipes: [FTRecipe] = []
  private var filteredAndSortedRecipes: [FTRecipe] = []
  private var error: FTError?
  private var searchText: String = ""

  var sortOrder: FTRecipeListSortOrder = .none
  weak var delegate: FTRecipeListViewModelDelegate?

  var numberOfRecipes: Int {
    return filteredAndSortedRecipes.count
  }

  var viewModelName: String {
    return "\(FTRecipeListViewModel.self)"
  }

  init(recipeListService: FTRecipeListServiceProtocol) {
    self.recipeListServiceImpl = recipeListService
  }

  func recipe(at index: Int) -> FTRecipe {
    return filteredAndSortedRecipes[index]
  }

  func showEmptyState() -> Bool {
    if self.numberOfRecipes == 0 {
      return true
    } else {
      return false
    }
  }

  func getError() -> FTError? {
    return self.error
  }

  func fetchRecipes() {

    recipeListServiceImpl.getFetchRecipes { [weak self] result in
      guard let self = self else {
        return
      }

      switch result {
        case .success(let recipes):
          self.allRecipes = recipes
          sortAndFilterRecipes()
          self.error = nil
          self.delegate?.didUpdateRecipeList()

        case .failure(let error):
          self.allRecipes = []
          self.filteredAndSortedRecipes = []
          self.error = error
          self.delegate?.didFailWithError(error)
      }
    }
  }

  func filterRecipes(searchText: String) {
    self.searchText = searchText
    sortAndFilterRecipes()
    delegate?.didUpdateRecipeList()
  }

  func sortBy(sortOrder: FTRecipeListSortOrder) {
    self.sortOrder = sortOrder
    sortAndFilterRecipes()
    delegate?.didUpdateRecipeList()
  }

  func sortAndFilterRecipes() {

    if self.searchText == "" {
      filteredAndSortedRecipes = allRecipes
    } else {
      filteredAndSortedRecipes = allRecipes.filter { recipe in
        return (recipe.name).lowercased().contains(searchText.lowercased()) || (recipe.cuisine).lowercased().contains(searchText.lowercased())
      }
    }

    switch sortOrder {
      case .none:
        break
      case .nameAscending:
        filteredAndSortedRecipes = filteredAndSortedRecipes.sorted(by: { $0.name < $1.name })
      case .nameDescending:
        filteredAndSortedRecipes = filteredAndSortedRecipes.sorted(by: { $0.name > $1.name })
    }

  }
}
