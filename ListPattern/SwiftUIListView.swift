//
//  SwiftUIListView.swift
//  ListPattern
//
//  Created by hiraoka on 2021/07/13.
//

import SwiftUI

struct SwiftUIListView: View {

    @State private var tasks: [Task] = []

    var body: some View {
        List {
            ForEach($tasks) { task in
                SwiftUIListCell(task: task)
                    .frame(minHeight: 40)
                    .swipeActions(edge: .leading) {
                        Button(action: {
                            task.wrappedValue.completed = true
                        }) {
                            Image(systemName: "checkmark")
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            guard let index = tasks.firstIndex(of: task.wrappedValue) else { return }
                            tasks.remove(at: index)
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
            }
        }
        .listStyle(.plain)
        .navigationBarItems(
            trailing: Button {
                tasks += [Task(title: "", completed: false)]
            } label: {
                Image(systemName: "plus")
            }
        )
        .onAppear {
            self.tasks = Task.samples
        }
    }
}

struct SwiftUIListCell: View {
    @Binding var task: Task

    var body: some View {
        HStack {
            Button {
                task.completed.toggle()
            } label: {
                Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
            }
            .buttonStyle(.borderless)


            TextEditor(text: $task.title)
        }
    }
}

struct SwiftUIListView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIListView()
    }
}
