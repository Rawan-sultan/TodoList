//
//  ToDoViewController.swift
//  TodoList
//
//  Created by 라완 💕 on 08/05/1444 AH.
//

import UIKit

class ToDoViewController: UIViewController {

    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func addButton(_ sender: UIButton) {
        guard let textTitle = titleField.text, !textTitle.isEmpty else{
            return
        }
        guard let textNote = textField.text, !textNote.isEmpty else{
            return
        }
        let date = datePicker.date
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newItem = TodoListItem(context: context)
        newItem.title = textTitle
        newItem.note = textNote
        newItem.date = date
        do{
            try context.save()
        }catch{
            print(error)
        }
        self.navigationController?.popViewController(animated: true)

      
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
    }

}
