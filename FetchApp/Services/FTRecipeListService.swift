//
//  FTRecipeListService.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import Foundation

struct FTAPI {
  private static let baseURL = "https://d3jbb8n5wk0qxi.cloudfront.net/"
  private static let recipesJSON = "recipes.json"
  private static let malformedRecipesJSON = "recipes-malformed.json"
  private static let emptyRecipesJSON = "recipes-empty.json"

  static func getRecipesJSONURL() -> URL? {
    return URL(string: baseURL + recipesJSON)
  }

  static func getMalformedJSONURL() -> URL? {
    return URL(string: baseURL + malformedRecipesJSON)
  }

  static func getEmptyRecipesJSONURL() -> URL? {
    return URL(string: baseURL + emptyRecipesJSON)
  }

}


class FTRecipeListService: FTRecipeListServiceProtocol {

  func fetchRecipes(completion: @escaping (Result<[FTRecipe], FTError>) -> Void) {

    if let url = FTAPI.getRecipesJSONURL() {
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "GET"

      let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in

        if let error = error {
          completion(.failure(FTError.requestFailed(error: error)))
          return
        }

        guard let data = data else {
          completion(.failure(FTError.dataNotFound))
          return
        }

        do {
          let decode = JSONDecoder()
          let recipeList = try decode.decode(FTRecipeList.self, from: data)
          completion(.success(recipeList.recipes))
        } catch {
          completion(.failure(FTError.jsonDecodingFailed(error: error)))
        }

      }

      task.resume()

    } else {
      completion(.failure(FTError.invalidURL))
    }

  }
}
