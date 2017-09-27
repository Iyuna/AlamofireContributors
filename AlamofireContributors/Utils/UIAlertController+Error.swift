//
//  UIAlertView+NSError.swift
//  AlamofireContributors
//
//  Created by Iryna Vasylieva on 9/27/17.
//  Copyright © 2017 Iryna Vasylieva. All rights reserved.
//

import UIKit

extension UIAlertController {
  convenience init(error: Error?) {
    let errorMessage: String
    switch error {
    case let serviceError as ServiceError:  errorMessage = serviceError.localizedDescription
    case .some(let error):                  errorMessage = error.localizedDescription
    case .none:                             errorMessage = localizedString("ErrorUnknown")
    }
    self.init(title: localizedString("ErrorTitle"), message: errorMessage, preferredStyle: .alert)

    let okAction = UIAlertAction(title: localizedString("ErrorOkButton"), style: .cancel)
    addAction(okAction)
  }
}
