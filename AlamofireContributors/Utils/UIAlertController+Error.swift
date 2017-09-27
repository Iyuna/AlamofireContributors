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
    case .none:                             errorMessage = "ErrorUnknown".localized
    }
    self.init(title: "ErrorTitle".localized, message: errorMessage, preferredStyle: .alert)
    addAction(UIAlertAction(title: "ErrorOkButton".localized, style: .cancel))
  }
}
