//
//  UIImage+Extensions.swift
//  MoneyBox
//
//  Created by Jonathan Simmons on 06/07/2023.
//

import UIKit


/// Extension to UIImage to enable the resizing of the Moneybox logo
extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
