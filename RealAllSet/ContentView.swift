//
//  ContentView.swift
//  RealAllSet
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let currentDate = Date()
    @Environment(\.modelContext) private var context
    @Query private var users: [User]
    let userName: String

    @State private var isDarkMode = false
    @State private var showSettings = false
    @State private var calendarNotes: [String: String] = [:]

    var body: some View {
        NavigationStack {
            ZStack {
                Color("vanilla")
                    .ignoresSafeArea()

                VStack {
                    // Top Greeting
                    HStack(alignment: .bottom) {
                        Text("Hello, \(userName)!")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Text(currentDate, style: .date)
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .padding([.top, .leading, .trailing], 30)

                    Spacer()
                    
                    // ADDED: Quick Access Card in the middle
                    QuickAccessCard()
                        .padding(.horizontal, 30)

                    Spacer()

                    // Bottom Toolbar
                    HStack(spacing: 12) {
                        NavigationLink {
                            ClassHome()
                        } label: {
                            Text("🎓 Class List")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                                .padding(.horizontal, 10)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(Color("lightgreen"))
                                .cornerRadius(8)
                        }

                        NavigationLink {
                            CalendarView()
                        } label: {
                            Text("🗓️ Calendar")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                                .padding(.horizontal, 10)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(Color("lightgreen"))
                                .cornerRadius(8)
                        }

                        NavigationLink {
                            Help()
                        } label: {
                            Text("ⓘ")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .frame(width: 50, height: 50)
                                .background(Color("lightgreen"))
                                .cornerRadius(8)
                        }

                        NavigationLink {
                            VolunteerLogView()
                        } label: {
                            Text("Log")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                                .background(Color("darkbluepurple"))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        Button {
                            showSettings = true
                        } label: {
                            Image(systemName: "gearshape")
                                .imageScale(.large)
                        }
                        .accessibilityLabel("Settings")

                        Button {
                            isDarkMode.toggle()
                        } label: {
                            Image(systemName: isDarkMode ? "moon.fill" : "sun.max")
                                .imageScale(.large)
                        }
                        .accessibilityLabel("Toggle Dark Mode")
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                NavigationView {
                    SettingsView(isDarkMode: $isDarkMode)
                }
                .preferredColorScheme(isDarkMode ? .dark : .light)
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

// MARK: - Simple Quick Access Card
struct QuickAccessCard: View {
    @State private var currentQuoteIndex = 0
    
    let inspirationalQuotes = [
        ("The best way to find yourself is to lose yourself in the service of others.", "Mahatma Gandhi"),
        ("No one has ever become poor by giving.", "Anne Frank"),
        ("We make a living by what we get, but we make a life by what we give.", "Winston Churchill"),
        ("Volunteers do not necessarily have the time; they just have the heart.", "Elizabeth Andrew"),
        ("The meaning of life is to find your gift. The purpose of life is to give it away.", "Pablo Picasso"),
        ("How wonderful it is that nobody need wait a single moment before starting to improve the world.", "Anne Frank"),
        ("The value of a man resides in what he gives and not in what he is capable of receiving.", "Albert Einstein"),
        ("We cannot live only for ourselves. A thousand fibers connect us with our fellow men.", "Herman Melville"),
        ("Service to others is the rent you pay for your room here on earth.", "Muhammad Ali"),
        ("Remember that the happiest people are not those getting more, but those giving more.", "H. Jackson Brown Jr.")
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("\"\(inspirationalQuotes[currentQuoteIndex].0)\"\n— \(inspirationalQuotes[currentQuoteIndex].1)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                
                Button(action: {
                    // Get a new random quote (make sure it's different from current)
                    var newIndex = Int.random(in: 0..<inspirationalQuotes.count)
                    while newIndex == currentQuoteIndex && inspirationalQuotes.count > 1 {
                        newIndex = Int.random(in: 0..<inspirationalQuotes.count)
                    }
                    currentQuoteIndex = newIndex
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            Text("✨ Quick Actions")
                .font(.title2)
                .fontWeight(.bold)
            
            HStack(spacing: 16) {
                NavigationLink {
                    VolunteerLogView()
                } label: {
                    VStack(spacing: 8) {
                        Image(systemName: "heart.fill")
                            .font(.title)
                            .foregroundColor(Color("darkgreen"))
                        Text("Log Hours")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .cornerRadius(12)
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink {
                    CalendarView()
                } label: {
                    VStack(spacing: 8) {
                        Image(systemName: "calendar")
                            .font(.title)
                            .foregroundColor(Color("darkbluepurple"))
                        Text("Schedule")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .cornerRadius(12)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            Text("🎯 Stay motivated and track your impact!")
                .font(.subheadline)
                .foregroundColor(.black)
                .italic()
                .multilineTextAlignment(.center)
        }
        .padding(20)
        .background(Color("lightgreen"))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
        .onAppear {
            // Pick a random quote when the view appears
            currentQuoteIndex = Int.random(in: 0..<inspirationalQuotes.count)
        }
    }
}

#Preview {
    ContentView(userName: "Geethika")
        .modelContainer(for: User.self, inMemory: true)
}
