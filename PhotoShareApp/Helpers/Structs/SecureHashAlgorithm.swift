//
//  SecureHashAlgorithm.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Berkay Sancar on 31.10.2022.
//

import Foundation
import CryptoKit

struct SHA {
    
    @available(iOS 13, *)
    static func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
}
