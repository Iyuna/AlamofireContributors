//
//  String+Localization.swift
//  AlamofireContributors
//
//  Created by Iryna Vasylieva on 9/27/17.
//  Copyright © 2017 Iryna Vasylieva. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
