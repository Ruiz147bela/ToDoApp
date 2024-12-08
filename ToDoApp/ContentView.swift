//
//  ContentView.swift
//  ToDoApp
//
//  Created by Isabela Ruiz Bustos on 8/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks: [Task] = [] // Lista de tareas
    @State private var newTaskTitle: String = "" // Texto para nueva tarea

    var body: some View {
        NavigationView {
            VStack {
                // Campo de texto para nueva tarea
                HStack {
                    TextField("Nueva tarea", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button(action: addTask) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing)
                }
                
                // Lista de tareas
                List {
                    ForEach(tasks) { task in
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .gray)
                                .onTapGesture {
                                    toggleTaskCompletion(task: task)
                                }
                            Text(task.title)
                                .strikethrough(task.isCompleted, color: .gray)
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .navigationTitle("Mis Tareas")
        }
        .onAppear(perform: loadTasks)
    }

    // Agregar una nueva tarea
    func addTask() {
        guard !newTaskTitle.isEmpty else { return }
        let newTask = Task(title: newTaskTitle, isCompleted: false)
        tasks.append(newTask)
        newTaskTitle = ""
        saveTasks()
    }

    // Cambiar el estado de completado de una tarea
    func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            saveTasks()
        }
    }

    // Eliminar una tarea
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTasks()
    }

    // Guardar tareas en UserDefaults
    func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }

    // Cargar tareas desde UserDefaults
    func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: "tasks"),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = decoded
        }
    }
}

