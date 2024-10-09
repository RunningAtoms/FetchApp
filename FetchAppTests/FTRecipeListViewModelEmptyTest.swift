//
//  FTRecipeListViewModelEmptyTest.swift
//  FetchAppTests
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import XCTest
@testable import FetchApp


final class FTRecipeListViewModelEmptyTest: XCTestCase {

  private var viewModel: FTRecipeListViewModelProtocol!
  private var emptyRecipeListService: MockFTRecipeListService!

  override func setUpWithError() throws {
    emptyRecipeListService = MockFTRecipeListService("recipes-empty")
    viewModel = FTRecipeListViewModel(recipeListService: emptyRecipeListService)
    viewModel.fetchRecipes()
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    viewModel = nil
    emptyRecipeListService = nil
    try super.tearDownWithError()
  }

  func test_EmptyRecipes() {
    XCTAssert(viewModel.numberOfRecipes == 0)
  }

  func test_errorNil() {
    XCTAssertNil(viewModel.getError())
  }

  func test_searchStringEmptyResults() {

    viewModel.filterRecipes(searchText: "08u12313")

    XCTAssert(viewModel.numberOfRecipes == 0)
  }

  func test_searchStringOneResult() {

    viewModel.filterRecipes(searchText: "Apam Balik")

    XCTAssert(viewModel.numberOfRecipes == 0)
  }

}

