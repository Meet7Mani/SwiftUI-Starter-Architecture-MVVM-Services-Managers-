//
//  MenuItem.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singh
//

import Foundation

struct MenuItem: Identifiable {
   
    let id                  = UUID()
    let title               : String
    let icon                : String
    let action              : () -> Void
}
