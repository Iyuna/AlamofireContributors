//
//  Contributor.swift
//  AlamofireContributors
//
//  Created by Iryna Vasylieva on 9/26/17.
//  Copyright © 2017 Iryna Vasylieva. All rights reserved.
//

import Foundation

struct ContributorDetails {
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
}

extension ContributorDetails: JSONInitable {
    init?(json: [String: Any]) {
        self.init(name: json[ApiKeys.name] as? String,
                  company: json[ApiKeys.company] as? String,
                  blog: json[ApiKeys.blog] as? String,
                  location: json[ApiKeys.location] as? String)
    }
}
