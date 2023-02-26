//
//  ViewController.swift
//  TodoList
//
//  Created by 라완 💕 on 08/05/1444 AH.
//

import UIKit
import CoreData
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var list = [TodoListItem]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let items = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ListTableViewCell

        cell.titleLabel.text = items.title
        cell.noteLabel.text = items.note
        let datee = items.date?.formatted(date: .numeric, time: .omitted)
        cell.dateLabel.text = "\(String(describing: datee!))"
        cell.accessoryType = items.check ? .checkmark : .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        list[indexPath.row].check.toggle()
        do {
            try managedObjectContext.save()
        }catch{
            print("\(error)")
        }
        tableView.reloadRows(at: [indexPath], with: .none)
        }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [self]  (contextualAction, view, boolValue) in
           let item = list[indexPath.row]
           managedObjectContext.delete(item)
           do {
               try managedObjectContext.save()
           }catch{
               print("\(error)")
           }
           self.list.remove(at: indexPath.row)
               tableView.reloadData()
           }
        deleteAction.backgroundColor = .red
      let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])

      return swipeActions
  }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let titleRequest:NSFetchRequest<TodoListItem> = TodoListItem.fetchRequest()
        do{
            list = try managedObjectContext.fetch(titleRequest)
            tableView.reloadData()
        }catch{
            print("\(error)")
            
        }
}

    @IBAction func addList(_ sender: UIBarButtonItem) {
        
        let toDoViewController = storyboard?.instantiateViewController(withIdentifier: "todoList") as! ToDoViewController
        navigationController?.pushViewController(toDoViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
