//
//  Contributor.swift
//  AlamofireContributors
//
//  Created by Iryna Vasylieva on 9/26/17.
//  Copyright © 2017 Iryna Vasylieva. All rights reserved.
//

import Foundation

struct Contributor {
    let id: Int
    let login: String
    let avatarURL: URL
    let contributionsNumber: Int
    let detailsURL: URL
    var details: ContributorDetails?
}

extension Contributor: JSONInitable {
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let login = json["login"] as? String,
            let avatarURLString = json["avatar_url"] as? String,
            let avatarURL = URL(string: avatarURLString),
            let contributionsNumber = json["contributions"] as? Int,
            let detailsURLString = json["url"] as? String,
            let detailsURL = URL(string: detailsURLString) else {
            return nil
        }
        self.id = id
        self.login = login
        self.avatarURL = avatarURL
        self.contributionsNumber = contributionsNumber
        self.detailsURL = detailsURL
    }
}
