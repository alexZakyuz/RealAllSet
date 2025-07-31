//
//  VolunteerEntry.swift
//  RealAllSet
//
//  Created by Scholar on 7/30/25.
//

import SwiftUI

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
    @State private var totalHours: Double = 0.0
    var hoursCompleted: Double {
        entries.reduce(0) { $0 + $1.hours }
    }
    var percentageCompletion: Double {
        return hoursCompleted / totalHours
    }

    var body: some View {
        ZStack {
            Color("vanilla")
                .ignoresSafeArea()

        NavigationView {
            VStack {
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
                }

                Text("Total Hours: \(hoursCompleted, specifier: "%.2f")")
                    .font(.title2)
                    .padding()
            }
            .background(Color("lightgreen").ignoresSafeArea())
            .navigationTitle("Volunteer Log")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                loadEntries()
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

#Preview {
    VolunteerLogView()
}
