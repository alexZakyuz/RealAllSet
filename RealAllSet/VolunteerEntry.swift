//
//  VolunteerEntry.swift
//  RealAllSet
//
//  Created by Scholar on 7/30/25.
//
import SwiftUI
import Foundation

// MARK: - Error Handling Models
enum VolunteerLogError: LocalizedError {
    case invalidHours
    case emptyActivity
    case saveFailed
    case loadFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidHours:
            return "Please enter valid hours (numbers only)"
        case .emptyActivity:
            return "Activity description cannot be empty"
        case .saveFailed:
            return "Failed to save entry. Please try again."
        case .loadFailed:
            return "Failed to load previous entries"
        }
    }
}

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
    @State private var showingGoalSheet = false
    
    // Form fields
    @State private var newActivity = ""
    @State private var newDate = Date()
    @State private var newHours = ""
    @State private var newNotes = ""
    
    // Goal setting
    @State private var goalHours: Double = 0
    @State private var newGoalText = ""
    
    // Error handling states
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = "Error"

    var totalHours: Double {
        entries.reduce(0) { $0 + $1.hours }
    }

    var progress: Double {
        min(totalHours / goalHours, 1.0)
    }

    var body: some View {
        NavigationView {
            ZStack {
                // FIXED: Proper background hierarchy
                Color("vanilla")
                    .ignoresSafeArea(.all)
                
                VStack(spacing: 20) {
                    // Goal Display Section
                    VStack(spacing: 8) {
                        Text("Volunteer Goal")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Button(action: {
                            newGoalText = String(Double(goalHours))
                            showingGoalSheet = true
                        }) {
                            HStack {
                                Text("\(Double(goalHours)) hours")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Image(systemName: "pencil")
                                    .font(.caption)
                            }
                            .foregroundColor(Color("darkgreen"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color("lightgreen").opacity(0.3))
                        .cornerRadius(8)
                    }
                    .padding(.top)
                    
                    if entries.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            Text("No volunteer entries yet.")
                                .font(.title2)
                                .foregroundColor(.gray)
                            Text("Tap + to add your first entry!")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(40)
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
                                .padding(.vertical, 8) // Increased padding for more space between entries
                                .listRowBackground(Color.white) // Clean white background for readability
                            }
                            .onDelete(perform: deleteEntry)
                        }
                        .listStyle(.insetGrouped)
                        .scrollContentBackground(.hidden) // FIXED: Hide default background
                        .background(Color.clear) // FIXED: Transparent list background
                    }

                    // RESTORED: Light green background around progress ring
                    ProgressRing(progress: progress, goalHours: goalHours, totalHours: totalHours)
                        .padding()
                        .background(Color("lightgreen"))
                        .cornerRadius(20)
                        .padding(.horizontal)
                }
                .padding(.horizontal)
            }
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
                loadGoal()
            }
            .onReceive(NotificationCenter.default.publisher(for: .init("ResetVolunteerEntries"))) { _ in
                entries.removeAll()
                goalHours = 0 // Reset to default goal
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
            .sheet(isPresented: $showingAddSheet) {
                addEntrySheet
            }
            .sheet(isPresented: $showingGoalSheet) {
                goalSettingSheet
            }
        }
        .navigationViewStyle(.stack) // FIXED: Consistent navigation style
    }
    
    // MARK: - Add Entry Sheet with Error Handling
    private var addEntrySheet: some View {
        NavigationView {
            ZStack {
                Color("vanilla")
                    .ignoresSafeArea(.all)
                
                Form {
                    Section(header: Text("Activity")) {
                        TextField("What did you do?", text: $newActivity)
                            .textFieldStyle(.roundedBorder)
                    }

                    Section(header: Text("Date")) {
                        DatePicker("Date", selection: $newDate, displayedComponents: .date)
                    }

                    Section(header: Text("Hours")) {
                        TextField("Hours (e.g. 2.5)", text: $newHours)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                    }

                    Section(header: Text("Notes (optional)")) {
                        TextField("Any additional info?", text: $newNotes)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                .scrollContentBackground(.hidden) // FIXED: Hide form background
                .background(Color.clear) // FIXED: Transparent form background
            }
            .navigationTitle("Add Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        clearForm()
                        showingAddSheet = false
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveNewEntry()
                    }
                    .disabled(newActivity.isEmpty || newHours.isEmpty)
                }
            }
        }
    }
    
    // MARK: - Goal Setting Sheet
    private var goalSettingSheet: some View {
        NavigationView {
            ZStack {
                Color("vanilla")
                    .ignoresSafeArea(.all)
                
                Form {
                    Section(header: Text("Set Your Volunteer Goal")) {
                        TextField("Total hours goal", text: $newGoalText)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                        
                        Text("Current goal: \(Double(goalHours)) hours")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .scrollContentBackground(.hidden) // FIXED: Hide form background
                .background(Color.clear) // FIXED: Transparent form background
            }
            .navigationTitle("Goal Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        newGoalText = ""
                        showingGoalSheet = false
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let newGoal = Double(newGoalText), newGoal > 0 {
                            goalHours = newGoal
                            saveGoal()
                            newGoalText = ""
                            showingGoalSheet = false
                        }
                    }
                    .disabled(Double(newGoalText) == nil || Double(newGoalText) ?? 0 <= 0)
                }
            }
        }
    }

    // MARK: - Error Handling Functions
    func saveNewEntry() {
        do {
            try validateAndSaveEntry()
            clearForm()
            showingAddSheet = false
        } catch {
            showError(error)
        }
    }
    
    func validateAndSaveEntry() throws {
        // Validate activity
        guard !newActivity.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw VolunteerLogError.emptyActivity
        }
        
        // Validate hours
        guard let hours = Double(newHours), hours > 0 else {
            throw VolunteerLogError.invalidHours
        }
        
        // Create entry
        let entry = VolunteerEntry(
            id: UUID(),
            activity: newActivity.trimmingCharacters(in: .whitespacesAndNewlines),
            date: newDate,
            hours: hours,
            notes: newNotes.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        
        // Add to entries
        entries.append(entry)
        
        // Save with error handling
        do {
            try saveEntries()
        } catch {
            // Remove the entry we just added if save fails
            entries.removeLast()
            throw VolunteerLogError.saveFailed
        }
    }

    func deleteEntry(at offsets: IndexSet) {
        let sortedEntries = entries.sorted { $0.date > $1.date }
        let entriesToDelete = offsets.map { sortedEntries[$0] }
        
        // Remove entries
        for entry in entriesToDelete {
            if let index = entries.firstIndex(where: { $0.id == entry.id }) {
                entries.remove(at: index)
            }
        }
        
        // Save changes
        do {
            try saveEntries()
        } catch {
            showError(VolunteerLogError.saveFailed)
        }
    }

    func saveEntries() throws {
        do {
            let data = try JSONEncoder().encode(entries)
            UserDefaults.standard.set(data, forKey: "volunteerEntries")
        } catch {
            throw VolunteerLogError.saveFailed
        }
    }

    func loadEntries() {
        do {
            guard let data = UserDefaults.standard.data(forKey: "volunteerEntries") else {
                // No saved data is fine, start with empty array
                return
            }
            entries = try JSONDecoder().decode([VolunteerEntry].self, from: data)
        } catch {
            showError(VolunteerLogError.loadFailed)
        }
    }
    
    func saveGoal() {
        UserDefaults.standard.set(goalHours, forKey: "volunteerGoal")
    }
    
    func loadGoal() {
        let savedGoal = UserDefaults.standard.double(forKey: "volunteerGoal")
        if savedGoal > 0 {
            goalHours = savedGoal
        }
    }
    
    func showError(_ error: Error) {
        if let volunteerError = error as? VolunteerLogError {
            alertTitle = "Error"
            alertMessage = volunteerError.localizedDescription
        } else {
            alertTitle = "Unexpected Error"
            alertMessage = error.localizedDescription
        }
        showingAlert = true
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
    var progress: Double
    var goalHours: Double
    var totalHours: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.purple.opacity(0.3), lineWidth: 20)

            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [Color("beigebrown"), Color("darkgreen")]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 1.0), value: progress)

            VStack(spacing: 4) {
                Text("\(Double(progress) * 100)%")
                    .font(.title)
                    .fontWeight(.bold)
                Text("\(Int(totalHours))/\(Double(goalHours)) hrs")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 180, height: 180)
        .padding()
    }
}

#Preview {
    VolunteerLogView()
}
