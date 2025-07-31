//
//  VolunteerEntry.swift
//  RealAllSet
//
//  Created by Scholar on 7/30/25.
//
import SwiftUI
import Foundation

struct VolunteerEntry: Identifiable, Codable {
    let id: UUID
    var activity: String
    var date: Date
    var hours: Double
    var notes: String
}

struct VolunteerLogView: View {
    @State private var entries: [VolunteerEntry] = []
    @State private var showingAddSheet = false

    @State private var newActivity = ""
    @State private var newDate = Date()
    @State private var newHours = ""
    @State private var newNotes = ""

    let goalHours = 500.0

    var totalHours: Double {
        entries.reduce(0) { $0 + $1.hours }
    }

    var progress: Double {
        min(totalHours / goalHours, 1.0)
    }

    var body: some View {
        ZStack {
            Color("vanilla")
                .ignoresSafeArea()

            NavigationView {
                VStack(spacing: 20) {
                    if entries.isEmpty {
                        Text("No volunteer entries yet.")
                            .padding()
                    } else {
                        List {
                            ForEach(entries.sorted { $0.date > $1.date }) { entry in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(entry.activity)
                                        .font(.headline)
                                    Text("Date: \(entry.date.formatted(date: .abbreviated, time: .omitted))")
                                    Text("Hours: \(entry.hours, specifier: "%.2f")")
                                    if !entry.notes.isEmpty {
                                        Text("Notes: \(entry.notes)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                            .onDelete(perform: deleteEntry)
                        }
                        .listStyle(.insetGrouped)
                    }

                    ProgressRing(progress: progress, goalHours: goalHours)
                }
                .background(Color("lightgreen").ignoresSafeArea())
                .navigationTitle("Volunteer Log")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton() // Enables swipe/delete and edit mode
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showingAddSheet = true }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .onAppear {
                    loadEntries()
                }
                .onReceive(NotificationCenter.default.publisher(for: .init("ResetVolunteerEntries"))) { _ in
                    entries.removeAll()
                }
                .sheet(isPresented: $showingAddSheet) {
                    NavigationView {
                        Form {
                            Section(header: Text("Activity")) {
                                TextField("What did you do?", text: $newActivity)
                            }

                            Section(header: Text("Date")) {
                                DatePicker("Date", selection: $newDate, displayedComponents: .date)
                            }

                            Section(header: Text("Hours")) {
                                TextField("Hours (e.g. 2.5)", text: $newHours)
                                    .keyboardType(.decimalPad)
                            }

                            Section(header: Text("Notes (optional)")) {
                                TextField("Any additional info?", text: $newNotes)
                            }
                        }
                        .navigationTitle("Add Entry")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    clearForm()
                                    showingAddSheet = false
                                }
                            }

                            ToolbarItem(placement: .confirmationAction) {
                                Button("Save") {
                                    if let hrs = Double(newHours), !newActivity.isEmpty {
                                        let entry = VolunteerEntry(
                                            id: UUID(),
                                            activity: newActivity,
                                            date: newDate,
                                            hours: hrs,
                                            notes: newNotes
                                        )
                                        entries.append(entry)
                                        saveEntries()
                                        clearForm()
                                        showingAddSheet = false
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    func deleteEntry(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
        saveEntries()
    }

    func saveEntries() {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: "volunteerEntries")
        }
    }

    func loadEntries() {
        if let data = UserDefaults.standard.data(forKey: "volunteerEntries"),
           let saved = try? JSONDecoder().decode([VolunteerEntry].self, from: data) {
            entries = saved
        }
    }

    func clearForm() {
        newActivity = ""
        newHours = ""
        newNotes = ""
        newDate = Date()
    }
}

// MARK: - Progress Ring View
struct ProgressRing: View {
    var progress: Double // Between 0 and 1
    var goalHours: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 20)

            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    AngularGradient(gradient: Gradient(colors: [Color("beigebrown"), Color("darkgreen")]), center: .center),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)

            VStack {
                Text("\(Int(progress * 100))%")
                    .font(.title)
                    .fontWeight(.bold)
                Text("\(Int(progress * goalHours))/\(Int(goalHours)) hrs")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 180, height: 180)
        .padding()
    }
}

#Preview {
    VolunteerLogView()
}


