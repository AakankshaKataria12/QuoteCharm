//
//  ContentView.swift
//  QuoteCharm Watch App
//
//  Created by Aakanksha Kataria on 28/07/23.
//

import SwiftUI
import UserNotifications

extension Font {
    static func customFont(_ name: String, size: CGFloat) -> Font {
        return Font.custom(name, size: size)
    }
}

struct ContentView: View {
    
    @State private var labelText = "Embrace the Power of Positivity!"
    @State private var bgColor: Color = Color(hex: 0xD3D3D3)
    @State private var emoji = "✨"
    
    let emojiOptions = ["🦋","🌸","🍀","🌟","☀️","🌈","🌊","🩷","❤️","🧡","💛","💚","🩵","💙","💜","🤍","💎","🌷","💐","🪽"]
    
    let singleColors: [Color] = [Color(hex: 0xF08DA9), Color(hex: 0xFEE3B8), Color(hex: 0xBCE4E3), Color(hex: 0xA6DAE8), Color(hex: 0xB9B2DC), Color(hex: 0xEBC8D5)]
    
    let quotes = ["Small steps everyday.","Growth is growth, no matter how small.","It’s gonna be okay.","You got this!","Fight for your fairytale.","Hang in there.","Hakuna matata.","Give your best, Always.","Anything is possible.","Be you, Do you, For you.","Everything that you are is Enough","You are Special.","Prove them Wrong.","If it’s meant to be, it’ll be.","The best is yet to come.","Never be afraid of Change.","All waves eventually pass.","No rain, No flowers.","Choose to shine.","Prioritise you.","Look forward with Hope, not backwards with Regret.","Love the person inside you.","Enjoy the Now.","Every fall is a chance to Rise.","You are Enough.","Wherever life plants you, bloom with Grace.","You were born to be Real, not Perfect.","Perfectly Imperfect.","Your possibilities are Endless.","Embrace you Flaws.","No risk, no story.","Breath.","You are inspiring.","Don’t give up.","What doesn’t kill you makes you stronger.","Believe in yourself.","Only strong birds fly in the storm.","Believe in the magic you have in yourself.","Relax and recharge.","Don’t worry, be Happy.","Let your soul Glow.","Your patience is you power.","Let it go.","Shake it Off!","One day at a time.","Happiness is a mood, Positivity is a mindset.","Trust the timing of your life.","Better an oops than a what if.","Enjoy the little things.","You were created to do magical things.","I am filled with inner strength.","I radiate love and positivity.","Today is a new beginning.","I embrace every challenge with courage.","I believe in my limitless potential.","I attract abundance and prosperity.","I am resilient and adaptable.","I create my own happiness.","I am in control of my destiny.","I am a beacon of positivity.","Every day is a gift; cherish it.","Embrace the journey; enjoy the ride.","You are a shining star in life.","Spread kindness like confetti.","Your dreams are within reach.","Gratitude unlocks abundance in life.","Positivity is a magnet for miracles.","Inhale confidence, exhale doubt.","You are the architect of your fate.","Life's challenges build inner strength."]
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(labelText)
                .font(.customFont("DMSerifDisplay-Regular", size: 16))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text(emoji)
                .font(.system(size: 25))
                .padding()
            
            Spacer()
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    labelText = quotes[Int.random(in: 0...quotes.count-1)]
                    bgColor = singleColors[Int.random(in: 0...singleColors.count-1)]
                    emoji = emojiOptions[Int.random(in: 0...emojiOptions.count-1)]
                    }
            }) {
                    VStack {
                        Text("Charm me")
                            .font(.customFont("AbrilFatface-Regular", size: 20))
                            .fontWeight(.bold)
                            .shadow(color: .white, radius: 15, x: 5, y: 5)
                    }
                }
            .padding()
            }
        .background(bgColor)
        .onAppear {
                    requestNotificationAuthorization()
                    scheduleHourlyNotifications()
                }
        }
    func requestNotificationAuthorization() {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) { granted, error in
                if granted {
                    print("Notification authorization granted")
                } else if let error = error {
                    print("Error requesting notification authorization: \(error.localizedDescription)")
                }
            }
        }

        private func scheduleHourlyNotifications() {
            let center = UNUserNotificationCenter.current()
            
            center.removeAllPendingNotificationRequests()
            
            let content = UNMutableNotificationContent()
            content.title = "QuoteCharm: Hourly Words of Wisdom"
            content.body = quotes[Int.random(in: 0...quotes.count-1)]
            content.sound = .none
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: true)
            
            let request = UNNotificationRequest(identifier: "hourlyReminder", content: content, trigger: trigger)
            center.add(request) { error in
                if let error = error {
                    print("Error scheduling hourly notification: \(error.localizedDescription)")
                } else {
                    print("Hourly notification scheduled successfully")
                }
            }
        }
}

extension Color {
    // Convenience initializer to create a color using a 32-bit hexadecimal value
    init(hex: UInt32) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
