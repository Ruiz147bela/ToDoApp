//
//  Task.swift
//  ToDoApp
//
//  Created by Isabela Ruiz Bustos on 8/12/24.
//

import Foundation

struct Task: Identifiable, Codable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}

