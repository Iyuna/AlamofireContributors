//
//  ContributorsTableViewController.swift
//  AlamofireContributors
//
//  Created by Iryna Vasylieva on 9/26/17.
//  Copyright © 2017 Iryna Vasylieva. All rights reserved.
//

import UIKit

class ContributorsTableViewController: UITableViewController {

    private var contributors = [Contributor]()

    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkService().fetchContributors {
            contributors in
            self.contributors = contributors.value ?? []
        }
    }
}

