//
//  ContributorTableViewCell.swift
//  AlamofireContributors
//
//  Created by Iryna Vasylieva on 9/26/17.
//  Copyright © 2017 Iryna Vasylieva. All rights reserved.
//

import UIKit
import AlamofireImage

class ContributorTableViewCell: UITableViewCell {
    static let cellIdentifier = "ContributorTableViewCell"

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var loginLabel: UILabel!
    @IBOutlet private var contributionsNumberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        prepareForReuse()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.af_cancelImageRequest()
        avatarImageView.image = nil
        loginLabel.text = nil
        contributionsNumberLabel.text = nil
    }

    func configure(with contributor: Contributor) {
        avatarImageView.af_setImage(withURL: contributor.avatarURL)
        loginLabel.text = contributor.login
        contributionsNumberLabel.text = String.localizedStringWithFormat(localizedString("%ld contribution(s)"),
                                                                         contributor.contributionsNumber)
    }
}
