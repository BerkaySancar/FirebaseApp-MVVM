//
//  FeedViewController.swift
//
//  Created by Berkay Sancar on 16.04.2022.
//

import UIKit
import SDWebImage

protocol FeedViewProtocol: AnyObject {
    
    func beginRefreshing()
    func endRefreshing()
    func dataRefreshed()
    func onError(title: String, message: String)
    func prepareTableView()
    func showCurrentUserEmail(email: String)
}

final class FeedViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var currentUserLabel: UILabel!
    
    private lazy var viewModel: FeedViewModelProtocol = FeedViewModel(view: self)
 
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
}
//MARK: - TableView Delegate & Data Source
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.postArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedCell else { return UITableViewCell()}
        
        cell.emailText.text = viewModel.postArr[indexPath.row].email
        cell.commentText.text = viewModel.postArr[indexPath.row].comment
        cell.postImageView.sd_setImage(with: URL(string: viewModel.postArr[indexPath.row].imageUrl))
       
        return cell
    }
}
//MARK: - FeedViewDelegate
extension FeedViewController: FeedViewProtocol {
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func showCurrentUserEmail(email: String) {
        self.currentUserLabel.text = email
    }
    
    func beginRefreshing() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func endRefreshing() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    func dataRefreshed() {
        self.tableView.reloadData()
    }
    
    func onError(title: String, message: String) {
        self.errorMessage(titleInput: title, messageInput: message)
    }
}
