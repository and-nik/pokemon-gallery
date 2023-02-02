//
//  String+ext.swift
//  PokemonApplication
//
//  Created by And Nik on 02.02.23.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }
}
