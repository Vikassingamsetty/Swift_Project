//
//  DataViewModel.swift
//  MVVM Demo
//
//  Created by Singamsetty Vikas on 06/11/21.
//

import Foundation

class DataViewModel {
    
    var userDetails:[DataModel] = [DataModel(firstName: "Varadic", lastName: nil),DataModel(firstName: "Bhosh", lastName: "Don"), DataModel(firstName: nil, lastName: "Someone")]
    
    func userNamesViewModel(completion: @escaping(Result<[DataModel], Error>) -> Void) {
        completion(.success(userDetails))
    }

    func contactsData(completion: @escaping(ContactModel?, Error?) -> Void) {
        
        guard let url = URL(string: "https://api.androidhive.info/contacts/") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                print("error in url")
                return
            }
            
            do{
                let result = try JSONDecoder().decode(ContactModel.self, from: data!)
                completion(result, nil)
            }catch{
                completion(nil, error.localizedDescription as? Error)
            }
            
        }.resume()
        
    }
    
}


