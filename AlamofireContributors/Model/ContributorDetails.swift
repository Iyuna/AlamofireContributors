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
        name = json["name"] as? String
        company = json["company"] as? String
        blog = json["blog"] as? String
        location = json["location"] as? String
    }
}
