//
//  Task.swift
//  ListPattern
//
//  Created by hiraoka on 2021/07/13.
//

import Foundation

struct Task: Codable, Identifiable, Hashable {
    var id: UUID = .init()
    var title: String
    var completed: Bool
    var createdAt: Date = .init()

    static let samples: [Task] = [
        Task(title: "task 1", completed: false),
        Task(title: "task 2", completed: true),
        Task(title: "task 3", completed: false),
        Task(title: "task 4", completed: false),
        Task(title: "task 5", completed: false),
        Task(title: "task 6", completed: true),
        Task(title: "task 7", completed: false)
    ]
    
}


