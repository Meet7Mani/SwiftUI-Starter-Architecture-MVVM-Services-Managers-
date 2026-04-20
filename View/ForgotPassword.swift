//
//  ForgotPassword.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singh
//

import SwiftUI

struct ForgotPassword: View {
    
    @StateObject var viewModel          = LoginViewModal()
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                FloatingTextField(text: $viewModel.email, placeholder: .constant("Email"), shouldFloat: .constant(!viewModel.email.isEmpty))

                Button(action: {
                    viewModel.forgotPassword()
                })
                {
                    Text("Done")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
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
        .navigationTitle(Text("Forgot Password"))
    }
}

#Preview {
    
    ForgotPassword()
}
