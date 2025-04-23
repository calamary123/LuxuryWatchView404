//
//  LuxuryWatchView403.swift
//  WatchWatch
//
//  Created by Hassan Ali on 06/03/2025.
//

import SwiftUI

struct LuxuryWatchView404: View {
    @State private var secondHandRotation: Double = 0
    @State private var minuteHandRotation: Double = 0
    @State private var gradientShift: Bool = false
    @State private var animatedText: String = ""
    let fullText = "Luxury Hand Watch ... "
   
    
    var body: some View {
        VStack {
            // Animated Text with Gradient Colors
            Text(animatedText)
                .font(.custom("Times New Roman", size: 40))
                .fontWeight(.bold)
                .foregroundStyle(
                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray,.red.opacity(0.6)]), startPoint: .leading, endPoint: .trailing)
                )
                .padding()
                .padding()
                .padding()
                .onAppear {
                    animateText()
                }
            
            ZStack {
                // Watch Strap with Continuous Gradient Animation
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black, Color.gray, Color.white,.pink.opacity(0.6)]),
                            startPoint: gradientShift ? .topLeading : .bottomTrailing,
                            endPoint: gradientShift ? .bottomTrailing : .bottomLeading
                        )
                    )
                    .frame(width: 60, height: 400)
                    .shadow(radius: 5)
                    .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: gradientShift)
                
                // Watch Face Outer Rim
                Circle()
                    .stroke(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .topLeading, endPoint: .bottomTrailing),
                        lineWidth: 5
                    )
                    .frame(width: 140, height: 140)
                    .background(Circle().fill(Color.white))
                
                // Hour Markers
                ForEach(0..<12) { i in
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: i % 3 == 0 ? 5 : 2, height: i % 3 == 0 ? 15 : 10)
                        .offset(y: -60)
                        .rotationEffect(.degrees(Double(i) * 30))
                }
                
                // Hour Hand
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 4, height: 40)
                    .offset(y: -20)
                    .rotationEffect(.degrees(minuteHandRotation / 12))
                
                // Minute Hand (Animated)
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 3, height: 50)
                    .offset(y: -25)
                    .rotationEffect(.degrees(minuteHandRotation))
                    .animation(.linear(duration: 3600).repeatForever(autoreverses: false), value: minuteHandRotation)
                
                // Second Hand (Animated)
                Rectangle()
                    .fill(Color.red.opacity(0.6))
                    .frame(width: 2, height: 60)
                    .offset(y: -30)
                    .rotationEffect(.degrees(secondHandRotation))
                    .animation(.linear(duration: 60).repeatForever(autoreverses: false), value: secondHandRotation)
                
                
                
                // Center Dot
                Circle()
                    .fill(Color.black)
                    .frame(width: 8, height: 8)
            }
            .frame(width: 140, height: 140)
            .onAppear {
                startAnimation()
                gradientShift.toggle()
            }
            .padding(.vertical,150)

            // Button to Trigger Animated Text Again
            Button(action: {
                animatedText = ""
                animateText()
            }) {
                Text("Animate Text")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray,Color.red.opacity(0.6)]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding()
        }
    }
    
    func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            secondHandRotation += 6
            minuteHandRotation += 0.1
        }
    }
    
    func animateText() {
        animatedText = ""
        var index = 0
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            if index < fullText.count {
                let character = fullText[fullText.index(fullText.startIndex, offsetBy: index)]
                animatedText.append(character)
                index += 1
            } else {
                timer.invalidate()
            }
        }
    }
}


struct LuxuryWatchView404_Previews: PreviewProvider {
    static var previews: some View {
        LuxuryWatchView404()
    }
}



