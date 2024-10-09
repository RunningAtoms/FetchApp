//
//  FTNiblessTableViewCell.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import Foundation
import UIKit

let ftTableViewCellContentInsets = UIEdgeInsets(top: 10.0, left: 12.0, bottom: 10.0, right: 12.0)

class FTNiblessTableViewCell: UITableViewCell {

  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  @available(*, unavailable,
              message: "Loading this view from a nib is unsupported in favor of initializer dependency injection."
  )

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
