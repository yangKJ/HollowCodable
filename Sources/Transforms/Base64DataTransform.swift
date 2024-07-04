//
//  Base64DataTransform.swift
//  CodableExample
//
//  Created by Condy on 2024/7/4.
//

import Foundation

/// Uses Base64 for (de)serailization of `Data`.
/// Decodes strictly valid Base64. This does not handle b64url encoding, invalid padding, or unknown characters.
public final class Base64DataTransform: DataTransform<Hollow.Base64Data> {
    
}
