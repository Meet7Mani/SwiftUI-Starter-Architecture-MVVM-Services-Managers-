//
//  FloatingTextField.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singh
//

import SwiftUI

struct FloatingTextField: View {
   
    @Binding var text                   : String
    @Binding var placeholder            : String
    @Binding var shouldFloat            : Bool
    @FocusState private var isFocused   : Bool
    
    var body: some View {
       
        ZStack(alignment: .leading) {
            
            // TextFiel
            TextField("", text: $text)
                .focused($isFocused)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(shouldFloat ? Color.black.opacity(0.6) : Color.gray.opacity(0.5), lineWidth: 1)
                        .frame(height: 44))
            // Floating label
            Text(placeholder)
                .fontWeight(shouldFloat ? .medium : .regular)
                .foregroundColor(shouldFloat ? .black : .gray)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                .offset(y: shouldFloat  ? -24 : 0)
                .padding(.horizontal, shouldFloat ? 2 : 0)
                .animation(.easeInOut(duration: 0.2), value: shouldFloat)
                .padding(.leading, shouldFloat ? 2 : 8)
                .allowsHitTesting(false)
                .disabled(false)
        }
        .padding(.vertical, 12)
    }
}

#Preview {
    FloatingTextField(text: .constant("text"), placeholder: .constant("placeholder"), shouldFloat: .constant(true))
}
