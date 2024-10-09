//
//  FTBrandedViewController.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import Foundation
import UIKit

import Foundation
import UIKit

let ftViewControllerContentInsets = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)

class FTBrandedViewController: FTNiblessViewController {

  public lazy var brandName: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.translatesAutoresizingMaskIntoConstraints = false
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.preferredFont(forTextStyle: .title1)
    label.text = "Fetch App Demo"
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(brandName)

    NSLayoutConstraint.activate([
      brandName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ftViewControllerContentInsets.top),
      brandName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ftViewControllerContentInsets.left),
      brandName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ftViewControllerContentInsets.right)
    ])
  }

  func showAlert(alertText : String, alertMessage : String, completionBlock: (()-> Void)? = nil) {
    let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
      completionBlock?()
    }))
    self.present(alert, animated: true, completion: nil)
  }
}
