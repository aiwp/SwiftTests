//
//  ContactsData.swift
//  TestCoreData
//
//  Created by Owen Carver on 9/23/20.
//  Copyright © 2020 pro.helloagain. All rights reserved.
//

import SwiftUI
import CoreData



//func addNewContact(){
//    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
//            return
//    }
//
//    let managedContext = appDelegate.persistentContainer.viewContext
//
//    let entity = NSEntityDescription.entity(forEntityName: "Contact", in: managedContext)!
//
//    let newContact = NSManagedObject(entity: entity, insertInto: managedContext)
//
//    newContact.setValue($newContact.wrappedValue, forKeyPath: "firstName")
//
//    do {
//        try managedContext.save()
//        print("saved sucessfully -- \($newContact.wrappedValue)")
//        loadContacts()
//    } catch let error as NSError {
//        print("Could not save. \(error), \(error.userInfo)")
//    }
//}


//  New code above

//  Old code below

//struct Contacts: Identifiable{
//    let id = UUID()
//    @State var firstName = ""
//    @State var lastName = ""
//    @State var email = ""
//    @State var image = ""
//    @State var phone = ""
//    @State var addressLine1 = ""
//    @State var addressLine2 = ""
//    @State var city = ""
//    @State var state = ""
//    @State var zip = ""
//}
        
//        = [
//        Contacts(firstName: "Jon", lastName: "Hemmer", email: "hemmacuda@gmail.com", image: "JonHemmer", phone: "702-573-9865"),
//    Contacts(firstName: "Owen", lastName: "Carver", email: "ocarver@gmail.com", image: "OwenCarver", phone: "702-306-6455" )
//]


