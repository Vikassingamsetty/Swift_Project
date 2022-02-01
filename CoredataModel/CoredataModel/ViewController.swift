//
//  ViewController.swift
//  CoredataModel
//
//  Created by Singamsetty Vikas on 30/10/21.
//

import UIKit
import CoreData

struct Details {
    let name: String
    let mail: String
    let phoneNo: String
}

class ViewController: UIViewController {

    var personDetails = [Details]()
    
    var detal = [NSManagedObject]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personDetails.append(Details(name: "sample1", mail: "sample@sample.com", phoneNo: "0987654321"))
        personDetails.append(Details(name: "DORA", mail: "Dora@sample.com", phoneNo: "1234567890"))
        //print(personDetails)
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            self.save(details: self.personDetails)
        }
        
        //fetchDetails()
    }
    
    func save(details: [Details]) {
        print(details, "detials one")
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)!
        let task = NSManagedObject(entity: entity, insertInto: context)
        
        for detail in details {
            task.setValue(detail.name, forKey: "name")
            task.setValue(detail.mail, forKey: "email")
            task.setValue(detail.phoneNo, forKey: "phoneNo")
            
            do {
                try context.save()
                print("Data Saved")
            } catch  {
                print("error while saving data")
            }
        }
        
        fetchDetails()
    }
    
    func fetchDetails() {
        let fetched = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do {
            detal = try context.fetch(fetched)
            getData()
        } catch  {
            print("unable to fetch data")
        }
    }
    
    func getData() {
        let value: Int = detal.count
        print(value, "value")
        for i in 0..<value {
            print(detal[i].value(forKey: "name") as! String)
        }
    }
    
}


