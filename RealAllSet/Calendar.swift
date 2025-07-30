//
//  Calendar.swift
//  RealAllSet
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate: Date? = nil
    @State private var noteText: String = ""
    @State private var notes: [String: String] = [:] // key: "yyyy-MM-dd"

    @State private var currentMonth: Date = Date()

    var body: some View {
        VStack {
            // MARK: - Month Navigation
            HStack {
                Button(action: {
                    changeMonth(by: -1)
                }) {
                    Image(systemName: "chevron.left")
                }

                Spacer()

                Text(monthYearFormatter.string(from: currentMonth))
                    .font(.title2).bold()

                Spacer()

                Button(action: {
                    changeMonth(by: 1)
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)

            // MARK: - Day of Week Labels
            let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }

            // MARK: - Dates Grid
            let dates = generateDates(for: currentMonth)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(dates, id: \.self) { date in
                    Button(action: {
                        selectedDate = date
                        noteText = notes[formatted(date)] ?? ""
                    }) {
                        Text("\(Calendar.current.component(.day, from: date))")
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(isSameDay(date1: date, date2: selectedDate) ? Color.blue.opacity(0.3) : Color.clear)
                            .clipShape(Circle())
                            .foregroundColor(isInCurrentMonth(date) ? .primary : .gray)
                    }
                }
            }
            .padding(.horizontal)

            Divider().padding(.vertical, 8)

            // MARK: - Note Section
            if let selected = selectedDate {
                VStack(alignment: .leading) {
                    Text("Notes for \(formatted(selected))")
                        .font(.headline)

                    TextEditor(text: $noteText)
                        .frame(height: 100)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))

                    Button("Save Note") {
                        notes[formatted(selected)] = noteText
                    }
                    .padding(.top, 5)
                }
                .padding()
            }

            Spacer()
        }
        .padding(.top)
    }

    // MARK: - Helper Functions

    func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    func changeMonth(by value: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }

    func isSameDay(date1: Date, date2: Date?) -> Bool {
        guard let date2 = date2 else { return false }
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }

    func isInCurrentMonth(_ date: Date) -> Bool {
        let current = Calendar.current.dateComponents([.year, .month], from: currentMonth)
        let comparing = Calendar.current.dateComponents([.year, .month], from: date)
        return current.year == comparing.year && current.month == comparing.month
    }

    func generateDates(for month: Date) -> [Date] {
        var calendar = Calendar.current
        calendar.firstWeekday = 1 // Sunday

        // Start of the month
        guard let monthInterval = calendar.dateInterval(of: .month, for: month),
              let firstWeekday = calendar.dateComponents([.weekday], from: monthInterval.start).weekday else {
            return []
        }

        var dates: [Date] = []

        // Calculate padding before the first day
        let prefixDays = firstWeekday - calendar.firstWeekday
        for i in stride(from: -prefixDays, to: 0, by: 1) {
            if let date = calendar.date(byAdding: .day, value: i, to: monthInterval.start) {
                dates.append(date)
            }
        }

        // Add all days in the current month
        var current = monthInterval.start
        while current < monthInterval.end {
            dates.append(current)
            current = calendar.date(byAdding: .day, value: 1, to: current)!
        }

        // Fill the grid with trailing days to make a full 6x7 layout if needed
        while dates.count % 7 != 0 {
            if let last = dates.last,
               let next = calendar.date(byAdding: .day, value: 1, to: last) {
                dates.append(next)
            }
        }

        return dates
    }

    private var monthYearFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "MMMM yyyy"
        return df
    }
}







#Preview {
    CalendarView()
}
