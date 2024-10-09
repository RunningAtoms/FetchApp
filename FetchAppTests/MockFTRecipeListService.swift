//
//  MockFTRecipeListService.swift
//  FetchAppTests
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import XCTest
@testable import FetchApp


@testable import FetchApp

class MockFTRecipeListService: FTRecipeListServiceProtocol {

  private var fileName: String

  init(_ jsonFileName: String) {
    fileName = jsonFileName
  }

  func fetchRecipes(completion: @escaping (Result<[FTRecipe], FTError>) -> Void) {
    guard let fileURL = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json") else {
      completion(.failure(FTError.invalidURL))
      return
    }

    do {
      let data = try Data(contentsOf: fileURL)
      let decoder = JSONDecoder()
      let testRecipeList = try decoder.decode(FTRecipeList.self, from: data)
      completion(.success(testRecipeList.recipes))
    } catch {
      completion(.failure(FTError.jsonDecodingFailed(error: error)))
    }
  }
}
