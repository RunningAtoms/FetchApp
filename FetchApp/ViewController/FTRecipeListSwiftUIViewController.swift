//
//  FTRecipeListSwiftUIViewController.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/12/24.
//

import Foundation
import UIKit

class FTRecipeListSwiftUIViewController: FTBrandedViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setupUI()
    self.view.backgroundColor = UIColor.white
  }

  private func setupUI() {

    let hostingController = FTAppFactory.shared.makeRecipeListSwiftUIHostingViewController()
    // Add the hosting controller as a child
    addChild(hostingController)

    // Add the SwiftUI view to the view hierarchy
    view.addSubview(hostingController.view)

    // Set the frame and constraints for the SwiftUI view
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])

    // Notify the child view controller (hosting controller) that it's been added
    hostingController.didMove(toParent: self)

  }

}
