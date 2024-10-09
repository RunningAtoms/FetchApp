//
//  FTRecipeListViewModelValidTest.swift
//  FetchAppTests
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import XCTest
@testable import FetchApp

final class FTRecipeListViewModelValidTest: XCTestCase {

  private var viewModel: FTRecipeListViewModelProtocol!
  private var validRecipeListService: MockFTRecipeListService!

  override func setUpWithError() throws {
    validRecipeListService = MockFTRecipeListService("recipes")
    viewModel = FTRecipeListViewModel(recipeListService: validRecipeListService)
    viewModel.fetchRecipes()
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    viewModel = nil
    validRecipeListService = nil
    try super.tearDownWithError()
  }

  func test_nonEmptyRecipes() {
    XCTAssert(viewModel.numberOfRecipes != 0)
  }

  func test_errorNil() {
    XCTAssertNil(viewModel.getError())
  }

  func test_recipesCount() {
    XCTAssert(viewModel.numberOfRecipes == 65)
  }

  func test_firstEntry() {

    let firstRecipe = viewModel.recipe(at: 0)

    XCTAssert(firstRecipe.cuisine == "Malaysian")
    XCTAssert(firstRecipe.name == "Apam Balik")

  }


  func test_searchStringEmptyResults() {

    viewModel.filterRecipes(searchText: "08u12313")

    XCTAssert(viewModel.numberOfRecipes == 0)
  }

  func test_searchStringOneResult() {

    viewModel.filterRecipes(searchText: "Apam Balik")

    XCTAssert(viewModel.numberOfRecipes == 1)
  }

  //Sort related tests
  func test_searchAndSort() {

    viewModel.filterRecipes(searchText: "British")
    viewModel.sortBy(sortOrder: .nameDescending)

    XCTAssert(viewModel.numberOfRecipes == 28)

    let expectedFirstRecipe = viewModel.recipe(at: 0)
    XCTAssert(expectedFirstRecipe.name == "Treacle Tart")
    XCTAssert(expectedFirstRecipe.cuisine == "British")


    let expectedLastRecipe = viewModel.recipe(at: viewModel.numberOfRecipes - 1)
    XCTAssert(expectedLastRecipe.name == "Apple & Blackberry Crumble")
    XCTAssert(expectedLastRecipe.cuisine == "British")
  }

  func test_searchAndSort2() {

    viewModel.filterRecipes(searchText: "")
    viewModel.sortBy(sortOrder: .nameDescending)

    XCTAssert(viewModel.numberOfRecipes == 65)

    let expectedFirstRecipe = viewModel.recipe(at: 0)
    XCTAssert(expectedFirstRecipe.cuisine == "French")
    XCTAssert(expectedFirstRecipe.name == "White Chocolate Crème Brûlée")

    let expectedSecondRecipe = viewModel.recipe(at: 1)
    XCTAssert(expectedSecondRecipe.cuisine == "Croatian")
    XCTAssert(expectedSecondRecipe.name == "Walnut Roll Gužvara")

  }


}

