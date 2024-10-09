//
//  FTRecipeListViewModelErrorTest.swift
//  FetchAppTests
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import XCTest
@testable import FetchApp

final class FTRecipeListViewModelErrorTest: XCTestCase {

  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }

  func testViewModelHandlesError() {

    let malformedRecipeListService = MockFTRecipeListService("recipes-malformed")
    let viewModel = FTRecipeListViewModel(recipeListService: malformedRecipeListService)

    viewModel.fetchRecipes()

    // Assert
    XCTAssertNotNil(viewModel.getError(), "Malformed json should encounter error.")
  }

}

