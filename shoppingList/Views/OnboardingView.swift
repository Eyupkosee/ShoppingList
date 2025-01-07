//
//  OnboardingView.swift
//  shoppingList
//
//  Created by eyüp köse on 7.01.2025.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentTab = 0
    @Binding var hasSeenOnboarding: Bool
    
    let onboardingData = [
        OnboardingPage(image: "cart.fill", title: "Alışveriş Listeleri", description: "Alışveriş listelerinizi kolayca oluşturun ve düzenleyin"),
        OnboardingPage(image: "checkmark.circle.fill", title: "Kolay Takip", description: "Alışverişlerinizi tek dokunuşla işaretleyin ve takip edin"),
        OnboardingPage(image: "arrow.down.doc.fill", title: "PDF Olarak Paylaş", description: "Alışveriş listelerinizi PDF formatında dışa aktararak istediğiniz kişilerle paylaşın")
    ]
    
    var body: some View {
        ZStack {
            Color.theme.mintPrimary.opacity(0.1)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    if currentTab < 2 {
                        Button("Atla") {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentTab = 2
                            }
                        }
                        .foregroundColor(Color.theme.mintPrimary)
                        .padding()
                    } else {
                        Color.clear
                            .frame(height: 50)
                    }
                }
                
                TabView(selection: $currentTab) {
                    ForEach(0..<onboardingData.count, id: \.self) { index in
                        OnboardingPageView(page: onboardingData[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack(spacing: 8) {
                    ForEach(0..<onboardingData.count, id: \.self) { index in
                        Circle()
                            .fill(currentTab == index ? Color.theme.mintPrimary : Color.gray)
                            .frame(width: 8, height: 8)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    currentTab = index
                                }
                            }
                    }
                }
                .padding(.bottom, 20)
                
                if currentTab == 2 {
                    Button("Başla") {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            hasSeenOnboarding = true
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.theme.mintPrimary)
                    .cornerRadius(25)
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                } else {
                    Button("İleri") {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentTab += 1
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.theme.mintPrimary)
                    .cornerRadius(25)
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
        }
    }
}

struct OnboardingPage: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let description: String
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
                .frame(height: 50)
            
            Image(systemName: page.image)
                .font(.system(size: 120))
                .foregroundColor(Color.theme.mintPrimary)
            
            Spacer()
                .frame(height: 50)
            
            Text(page.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.primaryText)
            
            Text(page.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.theme.secondaryText)
                .padding(.horizontal, 32)
            
            Spacer()
        }
    }
}
