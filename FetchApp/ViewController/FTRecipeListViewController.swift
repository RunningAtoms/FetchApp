//
//  FTRecipeListViewController.swift
//  FetchApp
//
//  Created by Vamsee Dheeraj Kanagala on 10/8/24.
//

import Foundation
import UIKit

class FTRecipeListViewController: FTBrandedViewController {

  private var viewModelImpl: FTRecipeListViewModelProtocol

  private lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchBar.placeholder = "Search for recipe name or cuisine"
    searchBar.delegate = self
    return searchBar
  }()

  private lazy var btnSortBy: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(FTRecipeListSortOrder.none.getButtonTitle(), for: .normal)
    button.backgroundColor = .lightGray
    button.setTitleColor(.black, for: .normal)
    button.addTarget(self, action: #selector(selectSortMethod), for: .touchUpInside)
    return button
  }()

  public lazy var lblEmptyResults: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.translatesAutoresizingMaskIntoConstraints = false
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.preferredFont(forTextStyle: .callout)
    label.text = "No matching results"
    label.isHidden = true
    return label
  }()

  private lazy var refreshControl: UIRefreshControl = {
    let refresh = UIRefreshControl()
    refresh.translatesAutoresizingMaskIntoConstraints = false
    refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refresh.addTarget(self, action: #selector(getNewData), for: .valueChanged)
    return refresh
  }()

  private lazy var recipeTableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.backgroundColor = .white
    table.dataSource = self
    table.delegate = self
    table.separatorInset = .zero
    table.separatorStyle = .singleLine
    table.keyboardDismissMode = .onDrag
    table.isHidden = false
    table.rowHeight = UITableView.automaticDimension
    table.refreshControl = refreshControl
    table.register(FTRecipeTableViewCell.self, forCellReuseIdentifier: FTRecipeTableViewCell.reusableID)
    return table
  }()

  init(viewModel: FTRecipeListViewModelProtocol) {
    self.viewModelImpl = viewModel
    super.init()
    self.viewModelImpl.delegate = self
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setupViewModel()
    setupUI()
    self.view.backgroundColor = UIColor.white
  }

  @objc private func selectSortMethod() {
    let alertController = UIAlertController(title: "Sort Recipes By", message: "Select an option to order recipes", preferredStyle: .actionSheet)

    FTRecipeListSortOrder.allCases.forEach {  aSortOrder in

      alertController.addAction(UIAlertAction(title: aSortOrder.description, style: .default, handler: { [weak self] _ in
        self?.viewModelImpl.sortBy(sortOrder: aSortOrder)
        self?.btnSortBy.setTitle(aSortOrder.getButtonTitle(), for: .normal)
      }))

    }

    alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

    present(alertController, animated: true, completion: nil)
  }

  private func setupViewModel() {
    viewModelImpl.fetchRecipes()
  }

  private func setupUI() {

    view.addSubview(recipeTableView)
    view.addSubview(lblEmptyResults)
    view.addSubview(searchBar)
    view.addSubview(btnSortBy)

    NSLayoutConstraint.activate([

      searchBar.topAnchor.constraint(equalTo: self.brandName.bottomAnchor, constant: ftViewControllerContentInsets.top),
      searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ftViewControllerContentInsets.left),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ftViewControllerContentInsets.right),

      btnSortBy.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: ftViewControllerContentInsets.top),
      btnSortBy.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ftViewControllerContentInsets.right),
      btnSortBy.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ftViewControllerContentInsets.left),
      btnSortBy.heightAnchor.constraint(equalToConstant: 64.0),

      lblEmptyResults.topAnchor.constraint(equalTo: btnSortBy.bottomAnchor, constant: ftViewControllerContentInsets.top),
      lblEmptyResults.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ftViewControllerContentInsets.right),
      lblEmptyResults.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ftViewControllerContentInsets.left),

      recipeTableView.topAnchor.constraint(equalTo: btnSortBy.bottomAnchor, constant: 0),
      recipeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -ftViewControllerContentInsets.bottom),
      recipeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ftViewControllerContentInsets.right),
      recipeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ftViewControllerContentInsets.left)

    ])
  }

  @objc private func getNewData() {
    viewModelImpl.fetchRecipes()
  }

}

extension FTRecipeListViewController: UITableViewDataSource, UITableViewDelegate {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModelImpl.numberOfRecipes
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: FTRecipeTableViewCell.reusableID) as? FTRecipeTableViewCell else {
      return UITableViewCell()
    }

    let arecipe = viewModelImpl.recipe(at: indexPath.row)
    cell.configure(recipe: arecipe)
    return cell
  }
}

extension FTRecipeListViewController: FTRecipeListViewModelDelegate {

  func didUpdateRecipeList() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else {
        return
      }

      self.refreshControl.endRefreshing()
      if self.viewModelImpl.showEmptyState() {
        self.lblEmptyResults.isHidden = false
        self.recipeTableView.isHidden = true
      } else {
        self.lblEmptyResults.isHidden = true
        self.recipeTableView.isHidden = false
      }
      self.recipeTableView.reloadData()
    }
  }

  func didFailWithError(_ error: FTError) {

    DispatchQueue.main.async { [weak self] in

      guard let self = self else {
        return
      }
      self.refreshControl.endRefreshing()
      self.showAlert(alertText: "Error", alertMessage: "\(error.localizedDescription)")
    }

  }

}

extension FTRecipeListViewController: UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.searchBar.endEditing(true)
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModelImpl.filterRecipes(searchText: searchText)
  }
}
