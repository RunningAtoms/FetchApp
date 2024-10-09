//
//  FTRecipe.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import Foundation

struct FTRecipe: FTBaseModel, Codable {
  var cuisine: String
  var name: String
  var photoURLLarge: String
  var photoURLSmall: String
  var sourceURL: String?
  var uuid: String
  var youtubeURL: String?

  enum CodingKeys: String, CodingKey {
    case cuisine, name
    case photoURLLarge = "photo_url_large"
    case photoURLSmall = "photo_url_small"
    case sourceURL = "source_url"
    case uuid
    case youtubeURL = "youtube_url"
  }

  func getRecipeNameForDisplay() -> String {
    return "Recipe Name: \(name)"
  }

  func getCuisineForDisplay() -> String {
    return "Cuisine: \(cuisine)"
  }

  func getSmallPhotoURL() -> URL? {
    return URL(string: photoURLSmall)
  }

  func getLargePhotoURL() -> URL? {
    return URL(string: photoURLLarge)
  }
  
}
