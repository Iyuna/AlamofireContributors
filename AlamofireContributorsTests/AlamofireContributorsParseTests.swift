//
//  AlamofireContributorsParseTests.swift
//  AlamofireContributorsTests
//
//  Created by Iryna Vasylieva on 9/26/17.
//  Copyright © 2017 Iryna Vasylieva. All rights reserved.
//

import XCTest
@testable import AlamofireContributors

class AlamofireContributorsParseTests: XCTestCase {
    
    func testContributorParsing() {
        let testPayload: [String: Any] = [
            "login": "cnoon",
            "id": 169110,
            "avatar_url": "https://avatars1.githubusercontent.com/u/169110?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/cnoon",
            "html_url": "https://github.com/cnoon",
            "followers_url": "https://api.github.com/users/cnoon/followers",
            "following_url": "https://api.github.com/users/cnoon/following{/other_user}",
            "gists_url": "https://api.github.com/users/cnoon/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/cnoon/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/cnoon/subscriptions",
            "organizations_url": "https://api.github.com/users/cnoon/orgs",
            "repos_url": "https://api.github.com/users/cnoon/repos",
            "events_url": "https://api.github.com/users/cnoon/events{/privacy}",
            "received_events_url": "https://api.github.com/users/cnoon/received_events",
            "type": "User",
            "site_admin": false,
            "contributions": 723
        ]
        let contributor = Contributor(json: testPayload)!
        XCTAssertEqual(contributor.id, 169110)
        XCTAssertEqual(contributor.login, "cnoon")
        XCTAssertEqual(contributor.avatarURL.absoluteString, "https://avatars1.githubusercontent.com/u/169110?v=4")
        XCTAssertEqual(contributor.contributionsNumber, 723)
    }

    func testContributorDetailsParsing() {
        let testPayload: [String: Any] = [
            "login": "cnoon",
            "id": 169110,
            "avatar_url": "https://avatars1.githubusercontent.com/u/169110?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/cnoon",
            "html_url": "https://github.com/cnoon",
            "followers_url": "https://api.github.com/users/cnoon/followers",
            "following_url": "https://api.github.com/users/cnoon/following{/other_user}",
            "gists_url": "https://api.github.com/users/cnoon/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/cnoon/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/cnoon/subscriptions",
            "organizations_url": "https://api.github.com/users/cnoon/orgs",
            "repos_url": "https://api.github.com/users/cnoon/repos",
            "events_url": "https://api.github.com/users/cnoon/events{/privacy}",
            "received_events_url": "https://api.github.com/users/cnoon/received_events",
            "type": "User",
            "site_admin": false,
            "name": "Christian Noon",
            "company": "@Nike-Inc ",
            "blog": "https://github.com/Alamofire/Foundation",
            "location": "Portland, OR",
            "email": NSNull(),
            "hireable": NSNull(),
            "bio": "Principal Engineer at @Nike-Inc. Swift enthusiast and active OSS contributor.",
            "public_repos": 19,
            "public_gists": 1,
            "followers": 897,
            "following": 18,
            "created_at": "2009-12-17T20:09:04Z",
            "updated_at": "2017-09-07T17:35:39Z"
        ]

        let contributorDetails = ContributorDetails(json: testPayload)!
        XCTAssertEqual(contributorDetails.name, "Christian Noon")
        XCTAssertEqual(contributorDetails.company, "@Nike-Inc ")
        XCTAssertEqual(contributorDetails.blog, "https://github.com/Alamofire/Foundation")
        XCTAssertEqual(contributorDetails.location, "Portland, OR")
    }
}
