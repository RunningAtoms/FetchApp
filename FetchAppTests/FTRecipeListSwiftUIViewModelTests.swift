//
//  FTRecipeListSwiftUIViewModelTests.swift
//  FetchAppTests
//
//  Created by Vamsee Dheeraj Kanagala on 10/13/24.
//

import XCTest
@testable import FetchApp

final class FTRecipeListSwiftUIViewModelTests: XCTestCase {

  private var viewModel: FTRecipeListSwiftUIViewModel!
  private var validRecipeListService: MockFTRecipeListService!

  override func setUpWithError() throws {
    validRecipeListService = MockFTRecipeListService("recipes")
    viewModel = FTRecipeListSwiftUIViewModel(recipeService: validRecipeListService)
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    viewModel = nil
    validRecipeListService = nil
    try super.tearDownWithError()
  }

  func testLoadRecipesSuccess() async {
    // Ensure no recipes loaded initially
    XCTAssertEqual(viewModel.downloadedRecipes.count, 0)

    let expectation = XCTestExpectation(description: "Recipes loaded successfully")

    // Call the loadRecipes function
    await viewModel.loadRecipes()

    try? await Task.sleep(nanoseconds: 1_000_000_000)

    // Ensure that the downloaded recipes are populated
    XCTAssertEqual(viewModel.downloadedRecipes.count, 65)
    XCTAssertEqual(viewModel.downloadedRecipes.first?.name, "Apam Balik")
    XCTAssert(viewModel.downloadedRecipes.first?.cuisine == "Malaysian")

    expectation.fulfill()

    await fulfillment(of: [expectation])
  }

  func test_searchStringEmptyResults() async {
    let expectation = XCTestExpectation(description: "test_searchStringEmptyResults")
    await viewModel.loadRecipes()
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    viewModel.searchString = "876781623"
    XCTAssert(viewModel.recipes.count == 0)

    expectation.fulfill()

    await fulfillment(of: [expectation])
  }

  func test_searchStringOneResult() async {
    let expectation = XCTestExpectation(description: "test_searchStringOneResult")
    await viewModel.loadRecipes()
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    viewModel.searchString = "Apam Balik"
    XCTAssert(viewModel.recipes.count == 1)
    expectation.fulfill()
    await fulfillment(of: [expectation])
  }

  //Sort related tests
  func test_searchAndSort() async {
    let expectation = XCTestExpectation(description: "test_searchAndSort")
    await viewModel.loadRecipes()
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    viewModel.sortOrder = .nameDescending
    viewModel.searchString = "British"
    XCTAssert(viewModel.recipes.count == 28)
    XCTAssert(viewModel.recipes.first?.name == "Treacle Tart")
    XCTAssert(viewModel.recipes.first?.cuisine == "British")
    XCTAssert(viewModel.recipes.last?.name == "Apple & Blackberry Crumble")
    XCTAssert(viewModel.recipes.last?.cuisine == "British")
    expectation.fulfill()
    await fulfillment(of: [expectation])
  }

  func test_searchAndSort2() async{

    let expectation = XCTestExpectation(description: "test_searchAndSort2")
    await viewModel.loadRecipes()
    try? await Task.sleep(nanoseconds: 1_000_000_000)

    viewModel.searchString = ""
    viewModel.sortOrder = .nameDescending

    XCTAssert(viewModel.recipes.count == 65)
    XCTAssert(viewModel.recipes.first?.cuisine == "French")
    XCTAssert(viewModel.recipes.first?.name == "White Chocolate Crème Brûlée")

    let expectedSecondRecipe = viewModel.recipes[1]
    XCTAssert(expectedSecondRecipe.cuisine == "Croatian")
    XCTAssert(expectedSecondRecipe.name == "Walnut Roll Gužvara")

    expectation.fulfill()
    await fulfillment(of: [expectation])

  }


}

