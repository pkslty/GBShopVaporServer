//
//  RemoveDuplicates.swift
//  
//
//  Created by Denis Kuzmin on 11.01.2022.
//

import Foundation

extension Array where Element: Hashable {
  func unsortedUniqueElements() -> [Element] {
    let set = Set(self)
    return Array(set)
  }
}
