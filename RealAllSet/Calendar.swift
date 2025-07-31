//
//  Calendar.swift
//  RealAllSet
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI
import Foundation

struct CalendarView: View {
    @State private var selectedDate: Date? = nil
    @State private var notes: [String: String] = [:] // key: "yyyy-MM-dd"
    @State private var currentMonth: Date = Date()
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var notesBinding: Binding<[String: String]> {
        Binding(
            get: { notes },
            set: { notes = $0 }
        )
    }

    private var daysInMonth: [Date] {
        generateCalendar(for: currentMonth)
    }

    private var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter
    }

    private var dateKeyFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

    var body: some View {
        ZStack {
            Color("vanilla")
                .ignoresSafeArea()

            VStack {
                HStack {
                    Button(action: {
                        changeMonth(by: -1)
                    }) {
                        Image(systemName: "chevron.left")
                    }

                    Spacer()

                    Text(monthYearFormatter.string(from: currentMonth))
                        .font(.headline)

                    Spacer()

                    Button(action: {
                        changeMonth(by: 1)
                    }) {
                        Image(systemName: "chevron.right")
                    }
                }
                .padding(.horizontal)

                let columns = Array(repeating: GridItem(.flexible()), count: 7)

                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(["S", "M", "T", "W", "T", "F", "S"], id: \.self) { day in
                        Text(day)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity)
                    }

                    ForEach(daysInMonth, id: \.self) { date in
                        let key = dateKeyFormatter.string(from: date)
                        let hasNote = notes[key, default: ""].trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false

                        Button(action: {
                            selectedDate = date
                            if hasNote {
                                alertMessage = "Note for this day:\n\n\(notes[key]!)"
                                showAlert = true
                            }
                        }) {
                            VStack(spacing: 4) {
                                Text("\(Calendar.current.component(.day, from: date))")
                                    .frame(width: 30, height: 30)
                                    .background(
                                        selectedDate == date ? Color.purple.opacity(0.3) : Color.clear
                                    )
                                    .clipShape(Circle())

                                if hasNote {
                                    Circle()
                                        .fill(Color.purple)
                                        .frame(width: 6, height: 6)
                                } else {
                                    Circle()
                                        .fill(Color.clear)
                                        .frame(width: 6, height: 6)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .disabled(!Calendar.current.isDate(date, equalTo: currentMonth, toGranularity: .month))
                    }
                }
                .padding()

                if let selected = selectedDate {
                    let key = dateKeyFormatter.string(from: selected)

                    VStack(alignment: .leading) {
                        Text("Notes for \(selected.formatted(date: .long, time: .omitted))")
                            .font(.headline)

                        TextEditor(text: Binding(
                            get: { notes[key, default: ""] },
                            set: {
                                notes[key] = $0
                                saveNotes()
                            }
                        ))
                        .frame(height: 150)
                        .padding()
                        .background(Color("darkgreen"))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                    .padding()
                }

                Spacer()
            }
            .padding(.top)
            .onAppear {
                loadNotes()
            }
            .onReceive(NotificationCenter.default.publisher(for: .init("ResetCalendarNotes"))) { _ in
                notes.removeAll()
                selectedDate = nil // Also clear selected date
            }
            .alert("Note", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }

    private func generateCalendar(for month: Date) -> [Date] {
        var calendar = Calendar.current
        calendar.firstWeekday = 1 // Sunday

        guard let range = calendar.range(of: .day, in: .month, for: month),
              let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: month)) else {
            return []
        }

        let firstWeekday = calendar.component(.weekday, from: firstDay)
        var days: [Date] = []

        for dayOffset in (1 - firstWeekday)..<range.count + 1 {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: firstDay) {
                days.append(date)
            }
        }

        return days
    }

    private func changeMonth(by value: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newDate
        }
    }

    private func saveNotes() {
        let defaults = UserDefaults.standard
        defaults.set(notes, forKey: "savedNotes")
    }

    private func loadNotes() {
        let defaults = UserDefaults.standard
        if let saved = defaults.dictionary(forKey: "savedNotes") as? [String: String] {
            notes = saved
        }
    }
}

#Preview {
    CalendarView()
}
