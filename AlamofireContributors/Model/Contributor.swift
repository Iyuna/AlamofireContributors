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
    var details: ContributorDetails?
}

extension Contributor: JSONInitable {
    init?(json: [String: Any]) {
        guard let id = json[ApiKeys.id] as? Int,
            let login = json[ApiKeys.login] as? String,
            let avatarURLString = json[ApiKeys.avatarURL] as? String,
            let avatarURL = URL(string: avatarURLString),
            let contributionsNumber = json[ApiKeys.contributions] as? Int else {
            return nil
        }
        self.init(id: id,
                  login: login,
                  avatarURL: avatarURL,
                  contributionsNumber: contributionsNumber,
                  details: nil)
    }
}
