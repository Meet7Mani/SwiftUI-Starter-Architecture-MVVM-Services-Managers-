//
//  ProfileView.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singhon 04/06/25.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel              = ProfileViewModal()
    @State var isShowPhotoOptions           : Bool                                  = false
    @State var isImagePickerPresented       : Bool                                  = false
    @State private var sourceType           : UIImagePickerController.SourceType    = .photoLibrary
    
    var body: some View {
        
        ZStack {
            VStack {
                
                uploadProfileImage()
                
                ScrollView {
                    FloatingTextField(text: $viewModel.firstName,   placeholder: .constant("First Name"), shouldFloat: .constant(!viewModel.firstName.isEmpty))
                    FloatingTextField(text: $viewModel.lastName,    placeholder: .constant("Last Name"),  shouldFloat: .constant(!viewModel.lastName.isEmpty))
                    FloatingTextField(text: $viewModel.phoneNumber, placeholder: .constant("Phone"),      shouldFloat: .constant(!viewModel.phoneNumber.isEmpty))
                    FloatingTextField(text: $viewModel.location,    placeholder: .constant("Location"),   shouldFloat: .constant(!viewModel.location.isEmpty))
                    
                    TextEditor(text: $viewModel.aboutMe)
                        .frame(height: 100)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            .frame(height: 100))
                    Text(viewModel.errorMessage ?? "")
                        .fontWeight(.light)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
                Button(action: {
                    viewModel.updateProfileData()
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
        .sheet(isPresented: $isImagePickerPresented) {
           
            ImagePicker(sourceType: sourceType) { image in
                
                viewModel.profileImage      = image
            }
        }
        .onAppear(perform: {
            viewModel.getProfileData()
        })
        .navigationTitle(Text("Profile"))
    }
    
    
    @ViewBuilder
    func uploadProfileImage() -> some View {
       
        Group {
            
            if let image = viewModel.profileImage {
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            }
            else {
               
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(.gray)
            }
        }
        .frame(width: 100, height: 100)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 5)
        .onTapGesture {
            withAnimation {
                isShowPhotoOptions.toggle()
            }
        }
        
        // Floating overlay options menu
        if isShowPhotoOptions {
           
            VStack(spacing: 10) {
                Button {
                    sourceType              = .camera
                    isImagePickerPresented  = true
                    withAnimation {
                        isShowPhotoOptions  = false
                    }
                } label: {
                    Label("Take Photo", systemImage: "camera")
                        .padding()
                        .background(Color.blue.opacity(0.9))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                
                Button {
                    sourceType              = .photoLibrary
                    isImagePickerPresented  = true
                    withAnimation {
                        isShowPhotoOptions  = false
                    }
                } label: {
                    Label("Choose from Gallery", systemImage: "photo.on.rectangle")
                        .padding()
                        .background(Color.blue.opacity(0.9))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .transition(.scale.combined(with: .opacity))
            .zIndex(1)
        }
    }
}
#Preview {
    ProfileView()
}
