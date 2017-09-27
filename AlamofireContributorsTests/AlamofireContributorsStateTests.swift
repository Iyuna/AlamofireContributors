//
//  AlamofireContributorsStateTests.swift
//  AlamofireContributorsTests
//
//  Created by Iryna Vasylieva on 9/26/17.
//  Copyright © 2017 Iryna Vasylieva. All rights reserved.
//

import XCTest
import Alamofire
@testable import AlamofireContributors

class MockServiceWithTwoItems: AlamofireContributorsAPI {
    func fetchContributors(completion: @escaping ((Result<[Contributor]>) -> Void)) {
        let firstContributor = Contributor(json: [
            "login": "cnoon",
            "id": 169110,
            "avatar_url": "https://avatars1.githubusercontent.com/u/169110?v=4",
            "contributions": 723
        ])!
        let secondContributor = Contributor(json: [
            "login": "mattt",
            "id": 7659,
            "avatar_url": "https://avatars0.githubusercontent.com/u/7659?v=4",
            "contributions": 229
        ])!
        completion(Result.success([firstContributor, secondContributor]))
    }

    func fetchContributorDetails(for contributor: Contributor,
                                 completion: @escaping ((_ result: Result<ContributorDetails>) -> Void)) {}
}

class MockServiceWithNoItems: AlamofireContributorsAPI {
    func fetchContributors(completion: @escaping ((Result<[Contributor]>) -> Void)) {
        completion(Result.success([]))
    }

    func fetchContributorDetails(for contributor: Contributor,
                                 completion: @escaping ((_ result: Result<ContributorDetails>) -> Void)) {}
}

class MockServiceWithError: AlamofireContributorsAPI {
    func fetchContributors(completion: @escaping ((Result<[Contributor]>) -> Void)) {
        completion(Result.failure(ServiceError.badPayload))
    }

    func fetchContributorDetails(for contributor: Contributor,
                                 completion: @escaping ((_ result: Result<ContributorDetails>) -> Void)) {}
}

class AlamofireContributorsStateTests: XCTestCase {
    let contributorsViewController: ContributorsViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let contributorsViewController = navigationController.topViewController as! ContributorsViewController
        _ = contributorsViewController.view // force load of the view to avoid crashes on uninitialized outlets
        return contributorsViewController
    }()

    func testTwoItemsState() {
        contributorsViewController.networkService = MockServiceWithTwoItems()
        contributorsViewController.loadData()

        if case .items(let contributors) = contributorsViewController.state {
            XCTAssertEqual(contributors.count, 2)
            XCTAssertEqual(contributorsViewController.tableView.isHidden, false)
            XCTAssertEqual(contributorsViewController.emptyTableLabel.isHidden, true)
        } else {
            XCTFail()
        }
    }

    func testNoItemsState() {
        contributorsViewController.networkService = MockServiceWithNoItems()
        contributorsViewController.loadData()

        if case .items(let contributors) = contributorsViewController.state {
            XCTAssertEqual(contributors.count, 0)
            XCTAssertEqual(contributorsViewController.tableView.isHidden, true)
            XCTAssertEqual(contributorsViewController.emptyTableLabel.isHidden, false)
        } else {
            XCTFail()
        }
    }

    func testErrorState() {
        contributorsViewController.networkService = MockServiceWithError()
        contributorsViewController.loadData()

        if case .failed(let error) = contributorsViewController.state {
            XCTAssert(error is ServiceError)
            XCTAssertEqual((error as! ServiceError).localizedDescription, ServiceError.badPayload.localizedDescription)
        } else {
            XCTFail()
        }
    }
}
