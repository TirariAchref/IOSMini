//
//  user.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import Foundation


struct UsersData : Decodable{
    let users : [User]?
    private  enum CodingKeys: String, CodingKey {
     
          case users = "results"
       }
}

struct User : Decodable {
    var _id :   String?
    var nom : String?
    var prenom :String?
    var email : String?
    var password : String?
    var phone : String?
    var money : String?
    var imageUrl : String?
    
  private  enum CodingKeys: String, CodingKey {
   
        case _id, email,nom,prenom,password,phone,money,imageUrl
     }
    
   
 
}
