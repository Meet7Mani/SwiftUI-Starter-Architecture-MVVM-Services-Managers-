//
//  MainView.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singh
//

import SwiftUI

struct MainView: View {
   
    @State private var isPushToProfileView      = false
    @State private var isPushToChangePassword   = false
    @State private var isMenuVisible            = false
    
    var body: some View {
        
        ZStack {
           
            NavigationView {
                
                VStack {
                    Text("Home Screen")
                    Spacer()
                }
                .navigationTitle("Home")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        
                        Button {
                            withAnimation {
                                isMenuVisible.toggle()
                            }
                        }
                        label: {
                            Image(systemName: "line.horizontal.3")
                                .foregroundStyle(.black)
                        }
                    }
                })
            }
            menuView()
        }
        .navigationDestination(isPresented: $isPushToChangePassword) {
            
            ChangePassword()
        }
        .navigationDestination(isPresented: $isPushToProfileView) {
            
            ProfileView()
        }
    }
    
    
    @ViewBuilder
    func menuView() -> some View {
        
        SideMenuView(
            menuItems: [MenuItem(title: "Profile",          icon: "person") {
                            isPushToProfileView.toggle()
                        },
                        MenuItem(title: "Settings",         icon: "gear") {
                            print("Open Settings")
                        },
                        MenuItem(title: "Privacy Policy",   icon: "document") {
                            print("Open Settings")
                        },
                        MenuItem(title: "Terms of Service", icon: "document.badge.arrow.up") {
                            print("Open Settings")
                        },
                        MenuItem(title: "Change Password",  icon: "lock") {
                            isPushToChangePassword.toggle()
                        },
                        MenuItem(title: "Logout",           icon: "arrow.backward.square") {
                            print("Logging out")
                        }],isShowing: $isMenuVisible)
    }
}
#Preview {
    MainView()
}
