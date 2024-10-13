//
//  FTRecipeRowSwiftUIView.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/13/24.
//

import SwiftUI
import Kingfisher

struct FTRecipeRowSwiftUIView: View {
  let recipe: FTRecipe

  var body: some View {
    HStack {
      if let imageURL = recipe.getSmallPhotoURL() {
        KFImage(imageURL)
          .resizable()
          .placeholder {
            // Placeholder while the image is loading
            ProgressView()
              .frame(width: 100, height: 100)
          }
          .aspectRatio(contentMode: .fill)
          .frame(width: 100, height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 10))
      }

      // Display the recipe name
      VStack(alignment: .leading) {
        Text(recipe.getRecipeNameForDisplay())
          .font(.headline)
        Text(recipe.getCuisineForDisplay())
          .font(.subheadline)
          .foregroundColor(.secondary)
      }
    }
    .padding(.vertical, 5)

  }
}

#Preview {
  FTRecipeRowSwiftUIView(recipe: FTRecipe(cuisine: "Croatian", name: "Walnut Roll Gužvara", photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/8f60cd87-20ab-419b-a425-56b7ad7c8566/large.jpg", photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/8f60cd87-20ab-419b-a425-56b7ad7c8566/small.jpg", uuid: "7d6a2c69-f0ef-459a-abf5-c2e90b6555ff"))
}
