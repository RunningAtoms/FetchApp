//
//  FTAppFactory.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import Foundation

class FTAppFactory {

  public func makeRootNavigationViewController() -> FTNavigationController {
    let rootNavigationController = FTNavigationController()
    rootNavigationController.isNavigationBarHidden = true
    rootNavigationController.setViewControllers([makeRecipeListViewController()], animated: true)
    return rootNavigationController
  }

  private func makeRecipeListViewController() -> FTRecipeListViewController {
    return FTRecipeListViewController(viewModel: makeRecipeListViewModel())
  }
  
  private func makeRecipeListService() -> FTRecipeListServiceProtocol {
   return FTRecipeListService()
  }

  private func makeRecipeListViewModel() -> FTRecipeListViewModelProtocol {
    return FTRecipeListViewModel(recipeListService: makeRecipeListService())
  }
}
