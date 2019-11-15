//
//  ContentView.swift
//  SwiftUIWithCoreData
//
//  Created by Sudhanshu Sudhanshu on 15/11/19.
//  Copyright © 2019 Sudhanshu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Person.entity(), sortDescriptors: []) var persons: FetchedResults<Person>
    
    var body: some View {
        VStack {
            List {
                ForEach(persons, id: \.id) {person in
                    Text(person.name ?? "Unknown")
                }
            .onDelete(perform: deleteItem)
            }
            
            Button("Add") {
                let firstNames = ["Harish", "Kiran", "Alok", "Sudhanshu"]
                
                let person = Person(context: self.moc)
                person.name = firstNames.randomElement()!
                person.id = UUID()
                
                try? self.moc.save()
            }
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        
        for index in offsets {
            let student  = persons[index]
            moc.delete(student)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
