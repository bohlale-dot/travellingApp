//
//  WelcomeView.swift
//  TravelApp
//
//  Created by Bohlale Manage on 2023/07/09.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            
            
            Image("welcome1")
                .resizable()
            //.scaledToFit()
                .ignoresSafeArea()
            
            
            VStack {
                Spacer()
                NavigationLink(destination: OnboardingView()) {
                    VStack{
                        Image(systemName: "arrow.right")
                            .resizable()
                            .scaledToFit()
                            .bold()
                            .background(.white)
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 84, height: 84)
                    .background(colorScheme == .dark ?
                                Color(.secondarySystemBackground) : Color(.systemBackground))
                    .cornerRadius(84)
                    .shadow(color: .primary.opacity(0.1), radius: 30, x: 4, y: 16)
                }.frame(maxWidth: .infinity, alignment: .trailing)

                
            }
        }
       
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    }


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
