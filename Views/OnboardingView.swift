//
//  OnboardingView.swift
//  TravelApp
//
//  Created by Bohlale Manage on 2023/07/09.
//

import SwiftUI

struct OnboardingItem: Hashable {
    var imageName: String;
    var title: String;
    var description: String;
    var tag: Int;
}

struct OnboardingView: View {
    
    @State var activeSlide: Int = 0;
    @Environment(\.colorScheme) var colorScheme
    
    var slides: [OnboardingItem] = [
        OnboardingItem(imageName: "ele", title: "Explore Destinations", description: "Exploring is an exhilarating journey that broadens horizons, immerses in diverse cultures, and creats unforgettable memories", tag: 0),
        OnboardingItem(imageName: "travel", title: "Choose a Destination", description: "Choosing the perfect destination involves considering personal interests and the desire to experience new adventures", tag: 1),
        OnboardingItem(imageName: "sky", title: "Fly to Desitination", description: "Get ready for your vacation", tag: 2),
    ]
    
    var body: some View {
        VStack {
            ZStack {
                TabView(selection: $activeSlide) {
                    ForEach(slides, id: \.self) {item in
                        OnboardingSlide(onboardingItem: item).tag(item.tag)
                    }
                    
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                VStack {
                    Spacer()
                    HStack(spacing: 8) {
                        ForEach(slides, id: \.self) { slide in
                            RoundedRectangle(cornerRadius: 13)
                                .frame(width: slide.tag == activeSlide ? 62 : 26, height: 11)
                                .foregroundColor(slide.tag == activeSlide ? Color("green") : Color("grey"))
                                .animation(.default, value: activeSlide)
                        }
                    }
                    .padding(.bottom, 16)
                    NavigationLink(destination: MainView()) {
                        VStack {
                            Image(systemName: "arrow.right")
                                .resizable()
                                .scaledToFit()
                                .bold()
                                .background(.white)
                                .frame(width: 24, height: 24)
                            
                               // .resizable()
                                //.scaledToFit()
                                //.background(.black)
                                //.frame(width: 20, height: 20)
                                //.bold()
                        }
                        .frame(width: 64, height: 64)
                        .background(colorScheme == .dark ? Color(.secondarySystemBackground) : Color(.systemBackground) )
                        .cornerRadius(84)
                        .shadow(color: .primary.opacity(Double(0.1)), radius: 30, x: 4, y: 16)
                        .scaleEffect(activeSlide == 2 ? 1 : 0)
                        .animation(.default, value: activeSlide)
                    }
                }
                .padding(.bottom, 74)
            }
        }.ignoresSafeArea()
    }
    }


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

struct OnboardingSlide: View {
    var onboardingItem: OnboardingItem;
    
    var body: some View {
        ZStack {
            VStack {
                Image(onboardingItem.imageName)
                    .resizable()
                    .scaledToFit()
                   // .frame(width: UIScreen.main.bounds.width * 0.65, height: UIScreen.main.bounds.width * 0.65)
                   // .ignoresSafeArea()
                    
                //            .frame(width: 300, height: 300)
                Text(onboardingItem.title)
                    .bold()
                    .font(.title2)
                    .padding(.top, 42)
                
                Text(onboardingItem.description)
                    .font(.body)
                    .padding(.top, 12)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 62)
                    .foregroundColor(Color(.gray))
            }
            .frame(maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

