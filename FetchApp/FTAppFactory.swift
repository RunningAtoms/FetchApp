//
//  FTAppFactory.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import Foundation
import SwiftUI

class FTAppFactory {

  public static let shared: FTAppFactory = FTAppFactory()

  private init() { }

  private var useSwiftUI = false

  public func makeRootNavigationViewController() -> FTNavigationController {
    let rootNavigationController = FTNavigationController()
    rootNavigationController.isNavigationBarHidden = true

    if useSwiftUI {
      rootNavigationController.setViewControllers([makeSwiftUIRecipeListViewController()], animated: true)
    } else {
      rootNavigationController.setViewControllers([makeRecipeListViewController()], animated: true)
    }
    return rootNavigationController
  }

  private func makeRecipeListViewController() -> FTRecipeListViewController {
    return FTRecipeListViewController(viewModel: makeRecipeListViewModel())
  }

  private func makeSwiftUIRecipeListViewController() -> FTRecipeListSwiftUIViewController {
    return FTRecipeListSwiftUIViewController()
  }


  private func makeRecipeListService() -> FTRecipeListServiceProtocol {
    return FTRecipeListService()
  }

  private func makeRecipeListViewModel() -> FTRecipeListViewModelProtocol {
    return FTRecipeListViewModel(recipeListService: makeRecipeListService())
  }

  @MainActor public func makeRecipeListSwiftUIHostingViewController() -> UIHostingController<FTRecipeListSwiftUIView> {
    // Set up the SwiftUI View
    let recipeViewModel = FTRecipeListSwiftUIViewModel(recipeService: makeRecipeListService())
    let recipeListView = FTRecipeListSwiftUIView(viewModel: recipeViewModel)

    // Embed the SwiftUI view inside a UIHostingController
    let hostingController = UIHostingController(rootView: recipeListView)
    return hostingController
  }
}
