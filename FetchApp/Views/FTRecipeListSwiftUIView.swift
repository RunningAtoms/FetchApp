//
//  FTRecipeListSwiftUIView.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/12/24.
//

import SwiftUI
import Kingfisher

struct FTRecipeListSwiftUIView: View {

  // Observing the RecipeViewModel
  @StateObject var viewModel: FTRecipeListSwiftUIViewModel

  var body: some View {
    NavigationView {
      VStack(spacing: 16) {

        HStack {
          Image(systemName: "magnifyingglass")
            .foregroundColor(.gray)
          TextField("Search Recipes", text: $viewModel.searchString)
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
        .padding(.horizontal)

        Menu {
          ForEach(FTRecipeListSortOrder.allCases, id: \.self) { sortOrder in
            Button(sortOrder.getButtonTitle()) {
              viewModel.sortOrder = sortOrder
            }
          }
        } label: {
          Label(viewModel.sortOrder.getButtonTitle(), systemImage: "arrow.up.arrow.down") // Up/Down arrow for sorting
            .font(.headline)
            .foregroundColor(.blue)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }

        // Check if there are any error messages
        if let errorMessage = viewModel.errorMessage {
          Text(errorMessage)
            .foregroundColor(.red)
        }

        if viewModel.recipes.isEmpty {
          Text("No results found")
            .font(.headline)
            .padding()
        }

        List(viewModel.recipes, id: \.uuid) { recipe in
          FTRecipeRowSwiftUIView(recipe: recipe)
            .onTapGesture {
              print("tapped \(recipe)")
            }
        }
        .refreshable {
          await viewModel.loadRecipes()
        }
        .navigationTitle("Recipes")

      }
    }
    .onAppear {
      Task {
        await viewModel.loadRecipes()
      }
    }
  }
}

// Preview to test in Xcode
struct RecipeListView_Previews: PreviewProvider {
  static var previews: some View {
    // Using a mock service for preview purposes
    let mockService = FTRecipeListService()
    FTRecipeListSwiftUIView(viewModel: FTRecipeListSwiftUIViewModel(recipeService: mockService))
  }
}


// Detail View to show full recipe information
struct RecipeDetailView: View {
  var recipe: FTRecipe

  var body: some View {
    VStack(spacing: 20) {
      // Large image from URL
      if let largePhotoURL = recipe.getLargePhotoURL() {
        KFImage(largePhotoURL)
          .resizable()
          .placeholder {
            ProgressView()
              .frame(width: 300, height: 200)
          }
          .aspectRatio(contentMode: .fit)
          .frame(maxWidth: .infinity)
          .cornerRadius(10)
          .padding()
      }

      // Recipe name and cuisine
      Text(recipe.getRecipeNameForDisplay())
        .font(.largeTitle)
        .fontWeight(.bold)
        .multilineTextAlignment(.center)
        .padding(.horizontal)

      Text(recipe.getCuisineForDisplay())
        .font(.title3)
        .foregroundColor(.secondary)
        .padding(.bottom, 20)

      Spacer() // Push content to the top

    }
    .padding()
    .navigationTitle("Recipe Details")
    .navigationBarTitleDisplayMode(.inline)
  }
}
