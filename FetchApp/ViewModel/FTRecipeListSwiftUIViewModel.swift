//
//  FTSwiftUIViewModel.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/12/24.
//

import Foundation

@MainActor
class FTRecipeListSwiftUIViewModel: ObservableObject {

  // Published property to notify the view when the recipe list changes
  @Published var recipes: [FTRecipe] = []
  @Published var errorMessage: String?
  @Published var searchString: String = ""{
    didSet {
      sortAndFilterRecipes()
    }
  }
  @Published var sortOrder: FTRecipeListSortOrder = .none {
    didSet {
      sortAndFilterRecipes()
    }
  }

  private(set) var downloadedRecipes: [FTRecipe] = []

  // Service conforming to FTRecipeListServiceProtocol
  private let recipeServiceImpl: FTRecipeListServiceProtocol

  // Dependency injection via initializer
  init(recipeService: FTRecipeListServiceProtocol) {
    self.recipeServiceImpl = recipeService
  }

  // Method to fetch recipes asynchronously
  func loadRecipes() async {
    do {
      // Call the async function to fetch recipes
      let fetchedRecipes = try await self.recipeServiceImpl.fetchRecipes()
      self.downloadedRecipes = fetchedRecipes
      self.sortAndFilterRecipes()
    } catch {
      self.downloadedRecipes = []
      self.sortAndFilterRecipes()
      self.errorMessage = "Failed to load recipes: \((error as! FTError).localizedDescription)"
    }
  }

  func sortAndFilterRecipes() {

    if self.searchString == "" {
      recipes = downloadedRecipes
    } else {
      recipes = downloadedRecipes.filter { recipe in
        return (recipe.name).lowercased().contains(searchString.lowercased()) || (recipe.cuisine).lowercased().contains(searchString.lowercased())
      }
    }

    switch sortOrder {
      case .none:
        break
      case .nameAscending:
        recipes = recipes.sorted(by: { $0.name < $1.name })
      case .nameDescending:
        recipes = recipes.sorted(by: { $0.name > $1.name })
    }

  }
}
