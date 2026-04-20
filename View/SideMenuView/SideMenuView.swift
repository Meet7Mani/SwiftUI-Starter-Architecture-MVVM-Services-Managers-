//
//  SideMenuView.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singh
//

import SwiftUI

struct SideMenuView: View {
   
    let menuItems                           : [MenuItem]
    @Binding var isShowing                  : Bool
   
    var body: some View {
     
        ZStack(alignment: .leading) {
          
            if isShowing {
           
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                      
                        withAnimation {
                            
                            isShowing       = false
                        }
                    }

                VStack() {
                    
                    Text("Menu")
                        .font(.largeTitle.bold())
                        .padding(.top, 40)
                        .frame(maxWidth: .infinity,alignment: .leading)

                    ForEach(menuItems) { item in
                        Button {
                            withAnimation {
                               
                                isShowing   = false
                                item.action()
                            }
                        } label: {
                           
                            HStack {
                                Image(systemName: item.icon)
                                Text(item.title)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity,alignment: .leading)
                        }
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: 250,alignment: .leading)
                .background(Color.white)
                .transition(.move(edge: .leading))
                .zIndex(1)
            }
        }
    }
}
#Preview {
    SideMenuView(menuItems: [], isShowing: .constant(true))
}
