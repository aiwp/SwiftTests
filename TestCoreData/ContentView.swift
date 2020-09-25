//
//  ContentView.swift
//  TestCoreData
//
//  Created by Owen Carver on 9/23/20.
//  Copyright © 2020 pro.helloagain. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var contacts:[NSManagedObject] = []
    @State var newContact = ""
    @State var showSheet = false
    @State var modifyingContact:String? = nil

    @State private var showingAddedAlert = false
    @State private var showingUpdatedAlert = false
    
    var body: some View {
        NavigationView{
            VStack {
                VStack {
                    TextField("Add New Contact", text: $newContact)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(5)
                    Button(action: {
                        self.addNewContact()
                        self.showingAddedAlert = true
                    }) {
                        Text("Add New Contact")
                    }.alert(isPresented: $showingAddedAlert) {
                        Alert(title: Text("Contact Added"), message: Text("Your list is growing!"), dismissButton: .default(Text("Got it!")))
                    }
                }.padding()
                .background(Color.init(white:0.9))
                .cornerRadius(10)
                .padding()
                
                VStack{
                    ForEach(contacts, id: \.self){ thisContact in
                        Button(action: {
                            self.modifyingContact = (thisContact as? Contact)?.firstName ?? "modifying string error"
                            self.newContact = (thisContact as? Contact)?.firstName ?? "new contact string error"
                            self.showSheet = true
                        }){
                            Text((thisContact as? Contact)?.firstName ?? "load error" )
                        }.sheet(isPresented: self.$showSheet){
                            VStack {
                                TextField("Update Contact", text: self.$newContact)
                                    .padding(10)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                HStack{
                                    Button(action: {
                                        if let contactToModify = self.modifyingContact {
                                            self.deleteContact(thisContactThing: contactToModify)
                                        }
                                    }) {
                                        Text("Delete Contact")
                                    }
                                    Button(action: {
                                        if let contactToModify = self.modifyingContact{
                                            self.updateContact(currentContactThing: contactToModify, newContactThing: self.$newContact.wrappedValue)
                                            self.showingUpdatedAlert = true
                                        }
                                        
                                    }) {
                                        Text("Update Contact")
                                    }.alert(isPresented: self.$showingUpdatedAlert) {
                                    Alert(title: Text("Contact Updated"), message: Text("Update successful."), dismissButton: .default(Text("Got it!")))
                                    }
                                }
                                
                            }.padding()
                            .background(Color.init(white:0.9))
                            .cornerRadius(10)
                            .padding()
                            VStack{
                                Button(action: {
                                    self.showSheet = false
                                }){
                                    Text("Close")
                                }
                            }
                        }
                    }
                }
                Spacer()
            }.onAppear(){
                self.loadContacts()
            }
        }
    }
    
    func clearNewField(){
        
    }
    
    func loadContacts(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
            
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Contact")
        
        do {
            contacts = try managedContext.fetch(fetchRequest)
            //  Close sheet self.showSheet = false
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func addNewContact(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: managedContext)!
        
        let newContact = NSManagedObject(entity: entity, insertInto: managedContext)
        
        newContact.setValue($newContact.wrappedValue, forKeyPath: "firstName")
        
        do {
            try managedContext.save()
            print("saved sucessfully -- \($newContact.wrappedValue)")
            self.loadContacts()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func updateContact(currentContactThing:String, newContactThing:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Contact")
        fetchRequest.predicate = NSPredicate(format: "firstName = %@", currentContactThing)
        do {
            let fetchReturn = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = fetchReturn[0] as! NSManagedObject
            
            objectUpdate.setValue(newContactThing, forKey: "firstName")
            
            do {
                try managedContext.save()
                print("updated successfully")
                self.loadContacts()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
        
    func deleteContact(thisContactThing:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Contact")
        
        fetchRequest.predicate = NSPredicate(format: "firstName = %@", thisContactThing)
        
        do {
            let fetchReturn = try managedContext.fetch(fetchRequest)
            let objectDelete = fetchReturn[0] as! NSManagedObject
            
            managedContext.delete(objectDelete)
            
            do {
                try managedContext.save()
                print("Deleted successfully")
                self.loadContacts()
                self.showSheet = false
            } catch let error as NSError {
                print("Could not delete. \(error), \(error.userInfo)")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    
    //  - - - - - Old Code Commented Below - - - - - -
    //
    //         NavigationView{
    //                   List {
    //                       ForEach(contacts) {contact in
    //                           NavigationLink(destination: ContactDetail(contact: contact)) { Text(contact.firstName + " " + contact.lastName)
    //                                }
    //                       }
    //                   }.navigationBarTitle(Text("Today's Call List"))
    //        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
