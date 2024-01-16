//
//  ModelViewModel.swift
//  JsonUiKit
//
//  Created by Daniel Moya on 15/1/24.
//

import Foundation

class ModelViewModel {
    
    public static var shared = ModelViewModel()
    var dataModel = Model(data: [])
    
    func fetch(completation: @escaping (_ done: Bool) -> Void){
        guard let url = URL(string: "https://reqres.in/api/users?page=2") else { return }
        
        URLSession.shared.dataTask(with: url){data,_,_ in
            guard let data = data else { return }
            
            do{
                let json = try JSONDecoder().decode(Model.self, from: data)
                DispatchQueue.main.async {
                    self.dataModel = json
                    completation(true)
                }
            }catch let error as NSError{
                print("Json error", error.localizedDescription)
            }
        }.resume()
    }
}
