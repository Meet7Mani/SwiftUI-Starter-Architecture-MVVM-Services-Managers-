//
//  SignUpView.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singh
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel                  = SignUpViewModal()
    
    var body: some View {
        
        ZStack {
            VStack {
                ScrollView {
                    VStack {
        
                        FloatingTextField(text: $viewModel.fullName,        placeholder: .constant("Full Name"),     shouldFloat: .constant(!viewModel.fullName.isEmpty))
                        FloatingTextField(text: $viewModel.email,           placeholder: .constant("Email Address"), shouldFloat: .constant(!viewModel.email.isEmpty))
                        FloatingTextField(text: $viewModel.password,        placeholder: .constant("Password"),      shouldFloat: .constant(!viewModel.password.isEmpty))
                        FloatingTextField(text: $viewModel.confirmPassword, placeholder: .constant("Confirm Password"), shouldFloat: .constant(!viewModel.confirmPassword.isEmpty))
                        
                        Button(action: {
                            viewModel.signUp()
                        })
                        {
                            Text("Submit")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                Spacer()
                Text(viewModel.errorMessage ?? "")
                    .fontWeight(.light)
                    .foregroundStyle(.red)
            }
            .padding()
            .disabled(viewModel.isLoading) // disable UI during loading
            .blur(radius: viewModel.isLoading ? 1 : 0)
            if viewModel.isLoading {
                
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                ProgressView("Loading...")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        .navigationTitle(Text("Sign-Up"))
    }
}
