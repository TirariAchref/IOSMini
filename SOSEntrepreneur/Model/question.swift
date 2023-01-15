//
//  question.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import Foundation



struct Question : Decodable{
    
    let _id : String?
    let subject : String?
    let description : String?
    let idClient : String?
    let nbrrate : String?
    let nbruser : String?
    
    private  enum CodingKeys: String, CodingKey {
     
          case _id, subject,description,idClient,nbruser,nbrrate
       }
      
   
   
}
