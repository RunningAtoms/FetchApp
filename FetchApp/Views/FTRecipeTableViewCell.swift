//
//  FTRecipeTableViewCell.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import Foundation
import UIKit
import Kingfisher

class FTRecipeTableViewCell: FTNiblessTableViewCell {
  public static let reusableID = "FTRecipeTableViewCell"

  private lazy var recipeImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
    imageView.clipsToBounds = true
    return imageView
  }()

  private lazy var nameAndCuisineStackView: UIStackView = {
    let stackView = UIStackView(frame: .zero)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .leading
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.spacing = 10
    stackView.addArrangedSubview(lblRecipeName)
    stackView.addArrangedSubview(lblCuisine)
    stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    stackView.setContentHuggingPriority(.required, for: .vertical)
    stackView.setContentCompressionResistancePriority(.required, for: .horizontal)
    stackView.setContentCompressionResistancePriority(.required, for: .vertical)
    return stackView
  }()

  private lazy var lblRecipeName: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.lineBreakMode = .byCharWrapping
    label.textAlignment = .left
    label.adjustsFontForContentSizeCategory = true
    label.setContentHuggingPriority(.required, for: .horizontal)
    label.setContentHuggingPriority(.required, for: .vertical)
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    return label
  }()

  private lazy var lblCuisine: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.lineBreakMode = .byCharWrapping
    label.textAlignment = .right
    label.adjustsFontForContentSizeCategory = true
    label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    label.setContentHuggingPriority(.required, for: .vertical)
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    return label
  }()

//  private lazy var btnYoutube: UIButton = {
//    let button = UIButton(type: .system)
//    button.setImage(UIImage(systemName: "play.rectangle.fill"), for: .normal)
//    button.tintColor = .red
//    button.translatesAutoresizingMaskIntoConstraints = false
//    button.setContentHuggingPriority(.required, for: .horizontal)
//    button.setContentHuggingPriority(.required, for: .vertical)
//    button.setContentCompressionResistancePriority(.required, for: .horizontal)
//    button.setContentCompressionResistancePriority(.required, for: .vertical)
//    return button
//  }()
//
//  private lazy var btnLink: UIButton = {
//    let button = UIButton(type: .system)
//    button.setImage(UIImage(systemName: "link"), for: .normal)
//    button.tintColor = .blue
//    button.translatesAutoresizingMaskIntoConstraints = false
//    button.setContentHuggingPriority(.required, for: .horizontal)
//    button.setContentHuggingPriority(.required, for: .vertical)
//    button.setContentCompressionResistancePriority(.required, for: .horizontal)
//    button.setContentCompressionResistancePriority(.required, for: .vertical)
//    return button
//  }()

  public func configure(recipe: FTRecipe) {

    contentView.subviews.forEach { $0.removeFromSuperview() }
    selectionStyle = .none
    backgroundColor = .white

    lblRecipeName.text = recipe.getRecipeNameForDisplay()
    lblCuisine.text = recipe.getCuisineForDisplay()
    recipeImageView.kf.setImage(with: recipe.getSmallPhotoURL()) { [weak self] result in
      switch result {
        case .success:
          break
        case .failure:
          self?.recipeImageView.kf.setImage(with: recipe.getLargePhotoURL(), placeholder: UIImage(systemName: "square.dashed"))
      }
    }

    self.contentView.addSubview(nameAndCuisineStackView)
    self.contentView.addSubview(recipeImageView)

    NSLayoutConstraint.activate([

      recipeImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: ftTableViewCellContentInsets.left),
      recipeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

      nameAndCuisineStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: ftTableViewCellContentInsets.top),
      nameAndCuisineStackView.leadingAnchor.constraint(equalTo: self.recipeImageView.trailingAnchor, constant: ftTableViewCellContentInsets.left),
      nameAndCuisineStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -ftTableViewCellContentInsets.right),
      contentView.bottomAnchor.constraint(equalTo: nameAndCuisineStackView.bottomAnchor, constant: ftTableViewCellContentInsets.bottom),

      contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120.0)
    ])
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    self.contentView.subviews.forEach {
      $0.removeFromSuperview()
    }
  }

}


