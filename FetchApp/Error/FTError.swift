//
//  FTError.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import Foundation

enum FTError: Error {

  case invalidURL
  case dataNotFound
  case jsonDecodingFailed(error: Error)
  case unknownError
  case invalidResponse
  case requestFailed(error: Error)

  var localizedDescription: String {
    switch self {
      case .invalidURL:
        return "The URL provided was invalid."
      case .requestFailed(let error):
        return "The request failed with error: \(error.localizedDescription)"
      case .invalidResponse:
        return "The response from the server was invalid."
      case .dataNotFound:
        return "The requested data could not be found."
      case .jsonDecodingFailed(let error):
        return "Failed to decode JSON with error: \(error.localizedDescription)"
      case .unknownError:
        return "An unknown error occurred."
    }
  }
}

