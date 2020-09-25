//
//  ContactDetail.swift
//  TestCoreData
//
//  Created by Owen Carver on 9/23/20.
//  Copyright © 2020 pro.helloagain. All rights reserved.
//


import SwiftUI

struct ContactDetail: View {
        
//    var contact: Contacts
//
    var body: some View {
//        VStack{
//            Image(contact.image).resizable().frame(width: 200, height: 200).cornerRadius(100).padding()
//            Text("Email: " + contact.email )
//            Text("Phone: " + contact.phone )
//            Spacer()
//            NavigationLink(destination: ContactEdit(contact: contact)) {
//                Text("Edit Contact")
//            }
//            Spacer()
//            Spacer()
//            Spacer()
//            Spacer()
//            Spacer()
//        }.navigationBarTitle(Text(contact.firstName + " " + contact.lastName))
        Text("Hello Again")
    }
    
}

struct ContactDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ContactDetail()
        }
        
    }
}
