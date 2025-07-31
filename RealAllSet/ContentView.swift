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
                            VolunteerLogView()
                        } label: {
                            Text("Log")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .frame(width: 50, height: 50)
                                .background(Color("lightgreen"))
                                .cornerRadius(8)
                        }

                        NavigationLink {
                            Help()
                        } label: {
                            Text("ⓘ")
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
            // Removed .navigationTitle("Home")
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
                }//navview
                .preferredColorScheme(isDarkMode ? .dark : .light)
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView(userName: "Test User")
        .modelContainer(for: User.self, inMemory: true)
}
