//
//  LoginView.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singh
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel  = LoginViewModal()
    @State private var isNewUser        = false
    @State private var isForgotPassword = false
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                FloatingTextField(text: $viewModel.email,    placeholder: .constant("Email"),    shouldFloat: .constant(!viewModel.email.isEmpty))
                FloatingTextField(text: $viewModel.password, placeholder: .constant("Password"), shouldFloat: .constant(!viewModel.password.isEmpty))
                
                Button(action: {
                    isForgotPassword.toggle()
                })
                {
                    Text("Forgot Password?")
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
                
                Button(action: {
                    viewModel.login()
                })
                {
                    Text("Login")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Button(action: {
                    isNewUser.toggle()
                })
                {
                    HStack {
                        Text("Don't have an account?")
                            .foregroundStyle(.gray)
                            .fontWeight(.light)
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                    }
                }
                Spacer()
                Text(viewModel.errorMessage ?? "")
                    .fontWeight(.light)
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity,alignment: .center)
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
        .onAppear {
            viewModel.errorMessage      = ""
        }
        .navigationDestination(isPresented: $isForgotPassword, destination: {
            ForgotPassword()
        })
        .navigationDestination(isPresented: $isNewUser, destination: {
            SignUpView()
        })
        .navigationDestination(isPresented: $viewModel.isLoggedIn, destination: {
            MainView()
        })
        .navigationTitle(Text("Login"))
    }
}

#Preview {
    LoginView()
}
