//
//  ContributorDetailsViewController.swift
//  AlamofireContributors
//
//  Created by Iryna Vasylieva on 9/26/17.
//  Copyright © 2017 Iryna Vasylieva. All rights reserved.
//

import UIKit
import AlamofireImage

class ContributorDetailsViewController: UIViewController {

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var companyLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var blogLabel: UILabel!
    @IBOutlet private var blogTextView: UITextView!
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!

    var contributor: Contributor!

    private var networkService: AlamofireContributorsAPI = {
        return NetworkService()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(contributor.login) " + "ContributorsDetailsTitle".localized.lowercased()
        avatarImageView.af_setImage(withURL: contributor.avatarURL)
        blogLabel.text = "ContributorsDetailsBlog".localized

        if let contributorDetails = contributor.details {
            configure(with: contributorDetails)
        } else {
            nameLabel.text = nil
            companyLabel.text = nil
            locationLabel.text = nil
            blogTextView.text = nil

            activityIndicatorView?.startAnimating()
            self.networkService.fetchContributorDetails(for: contributor) {
                [weak self] result in
                guard self != nil else { return }
                self!.activityIndicatorView.stopAnimating()
                switch result {
                case .failure(let error):
                    self!.present(UIAlertController(error: error), animated: true)
                case .success(let contributorDetails):
                    self!.contributor.details = contributorDetails
                    self!.configure(with: contributorDetails)
                }
            }
        }
    }
}

// MARK: - Private interface
private extension ContributorDetailsViewController {
    func configure(with contributorDetails: ContributorDetails) {
        nameLabel.text = contributorDetails.name
        companyLabel.text = contributorDetails.company
        locationLabel.text = contributorDetails.location
        blogTextView.text = contributorDetails.blog
    }
}
