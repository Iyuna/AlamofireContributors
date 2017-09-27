//
//  ContributorsViewController.swift
//  AlamofireContributors
//
//  Created by Iryna Vasylieva on 9/26/17.
//  Copyright © 2017 Iryna Vasylieva. All rights reserved.
//

import UIKit

class ContributorsViewController: UIViewController {

    private enum Constants {
        static let rowHeight = CGFloat(61)
    }

    @IBOutlet var tableView: UITableView!
    @IBOutlet var emptyTableLabel: UILabel!
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!

    var networkService: AlamofireContributorsAPI = {
        return NetworkService()
    }()

    enum TableState {
        case loading
        case failed(Error)
        case items([Contributor])
    }
    var state = TableState.loading {
        didSet {
            switch state {
            case .loading:
                emptyTableLabel.isHidden = true
                activityIndicatorView.startAnimating()
            case .failed(let error):
                activityIndicatorView.stopAnimating()
                present(UIAlertController(error: error), animated: true)
            case .items(let contributors):
                activityIndicatorView.stopAnimating()
                let isEmpty = contributors.count == 0
                tableView.isHidden = isEmpty
                emptyTableLabel.isHidden = !isEmpty
                if !isEmpty { tableView.reloadData() }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ContributorsTitle".localized
        emptyTableLabel.text = "ContributorsEmptyList".localized
            
        tableView.rowHeight = Constants.rowHeight

        loadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (state, segue.destination) {
        case (.items(let contributors), let detailsViewController as ContributorDetailsViewController):
            detailsViewController.contributor = contributors[tableView.indexPathForSelectedRow!.row]
        default:
            super.prepare(for: segue, sender: sender)
        }
    }

    func loadData() {
        state = .loading
        self.networkService.fetchContributors {
            [weak self] result in
            guard self != nil else { return }
            switch result {
            case .failure(let error):           self!.state = .failed(error)
            case .success(let contributors):    self!.state = .items(contributors)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension ContributorsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case .items(let contributors) = state else { return 0 }
        return contributors.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard case .items(let contributors) = state else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: ContributorTableViewCell.cellIdentifier,
                                                 for: indexPath) as! ContributorTableViewCell
        cell.configure(with: contributors[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ContributorsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
