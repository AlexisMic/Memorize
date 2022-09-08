//
//  Theme.swift
//  Memorize
//
//  Created by Ana Clara Schotte on 29/07/2022.
//

import Foundation
import SwiftUI

struct Theme: Identifiable, Equatable {

    var id: Int
    var name: String?
    var color: Color?
    var emojis: Array<String>?
    var numberOfPairs: Int
    
}
