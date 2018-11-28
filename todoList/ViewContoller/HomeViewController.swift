//
//  ViewController.swift
//  todoList
//
//  Created by rishad k on 27/11/18.
//  Copyright © 2018 rishad k. All rights reserved.
//

import UIKit
import Alamofire
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTask, CheckBox {
    func addTask(name: String, index: Int, edit: Bool) {
        
        if edit
        {
            
            tasks[index].name=name
            tableView.reloadData()
            self.UpdateTaskNmae(name: name, id: tasks[index].id)
        }
        else
        {
            AddTasks(name: name)
            
            
        }
    }
    @IBOutlet weak var tableView: UITableView!
    var tasks: [Tasks] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.GetAllTasks()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    // to fill the table with the tasks
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        cell.taskNameLabel.text = tasks[indexPath.row].name
        
        if tasks[indexPath.row].checked {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxFILLED "), for: UIControlState.normal)
        } else {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxOUTLINE "), for: UIControlState.normal)
        }
        
        cell.delegate = self
        cell.tasks = tasks
        cell.indexP = indexPath.row
        
        return cell
    }
    
    //it will return the number of tasks
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at:indexPath)
        let edit = editAction(at:indexPath)
        return UISwipeActionsConfiguration(actions: [delete,edit])
        
    }
    //edit action is show only row swipe on left diraction
    func editAction(at indexPath:IndexPath)->UIContextualAction
    {
        
        let action = UIContextualAction(style: .normal, title: "Edit"){(action,view,completion) in
            completion(true)
            let addTodoView=self.storyboard?.instantiateViewController(withIdentifier: "AddTaskController_id") as! AddTaskController
            addTodoView.index=indexPath.row
            addTodoView.name=self.tasks[indexPath.row].name
            addTodoView.edit=true
            addTodoView.delegate = self
            self.navigationController?.pushViewController(addTodoView, animated: true)
            
            
            
        }
        action.backgroundColor = .gray
        return action
    }
    
    //delete action is show only row swipe on left diraction
    func deleteAction(at indexPath:IndexPath)->UIContextualAction
    {
        
        let action = UIContextualAction(style: .destructive, title: "Delete"){(action,view,completion) in
            
            self.DeleteFromServer(id: self.tasks[indexPath.row].id)
            
            self.tasks.remove(at:indexPath.row)
            self.tableView.reloadData()
            completion(true)
            
        }
        action.backgroundColor = .red
        return action
    }
    //tabebar button for adding new task it will rediract into task creation view
    @IBAction func buttonAddTaskAction(_ sender: UIBarButtonItem) {
        
        let addTodoView=self.storyboard?.instantiateViewController(withIdentifier: "AddTaskController_id") as! AddTaskController
        
        addTodoView.edit=false
        addTodoView.delegate = self
        self.navigationController?.pushViewController(addTodoView, animated: true)
        
        
    }
    
    
    
    //check box for all row for making the task complete
    func checkBox(state: Bool, index: Int?) {
        if state
        {
            tasks[index!].checked = state
            tableView.reloadRows(at: [IndexPath(row: index!, section: 0)], with: UITableViewRowAnimation.none)
            MakeAsComplete(id: tasks[index!].id)
        }
    }
    // this ShowAlertForNetworkNotRechable function writen  for show that if any network rechabilty problem
    func ShowAlertForNetworkNotRechable()
    {
        let alert = UIAlertController(title: "Warning", message: "Network not rechable", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    //API CALLINGS
    
    //this function will delete the task from server it accept the task id for identify spacific task if it is success the it will give 200 status code
    func  DeleteFromServer(id:Int)
    {
        if NetworkFunctions.NetworkRechability()
        {
            DispatchQueue.global(qos: .background).async {
                print("Run on background thread")
                var params : [String:Any]
                params=["todo_id":id]
                
                Alamofire.request(AppURLS.DELETE_TASK_UEL, method: .post, parameters: params, encoding: JSONEncoding.default)
                    .responseJSON { response in
                        debugPrint(response)
                        
                        if response.response!.statusCode==200
                        {
                            if response.result.value != nil{
                                
                                
                                
                                
                            }
                            
                        }
                }
                DispatchQueue.main.async {
                    print("We finished that.")
                    // only back on the main thread, may you access UI:
                    self.tableView.reloadData()
                }
            }
            
            
        }
        else
        {
            self.ShowAlertForNetworkNotRechable() }
        
        
    }
    // this function will update the task name in server it will accept tow paramenter name and id the name is the name name for replace and the id for identify the task
    func UpdateTaskNmae(name:String,id:Int)
    {
        if NetworkFunctions.NetworkRechability()
        {
            DispatchQueue.global(qos: .background).async {
                print("Run on background thread")
                var params : [String:Any]
                params=["name":name,"todo_id":id]
                
                Alamofire.request(AppURLS.UPDATE_TASK_NAME_UEL, method: .post, parameters: params, encoding: JSONEncoding.default)
                    .responseJSON { response in
                        debugPrint(response)
                        
                        if response.response!.statusCode==200
                        {
                            if response.result.value != nil{
                                
                                
                                
                                
                            }
                            
                        }
                }
                DispatchQueue.main.async {
                    print("We finished that.")
                    // only back on the main thread, may you access UI:
                    self.tableView.reloadData()
                }
            }
            
            
        }
        else
        {
            self.ShowAlertForNetworkNotRechable()}
        
        
    }
    //this function will change the status of task in server side
    func MakeAsComplete(id:Int)
    {
        
        
        if NetworkFunctions.NetworkRechability()
        {
            DispatchQueue.global(qos: .background).async {
                print("Run on background thread")
                var params : [String:Any]
                params=["todo_id":id]
                
                Alamofire.request(AppURLS.MAKE_AS_COMPLETE_TASK_UEL, method: .post, parameters: params, encoding: JSONEncoding.default)
                    .responseJSON { response in
                        debugPrint(response)
                        
                        if response.response!.statusCode==200
                        {
                            if response.result.value != nil{
                                
                            }
                            
                        }
                }
                DispatchQueue.main.async {
                    print("We finished that.")
                    // only back on the main thread, may you access UI:
                    self.tableView.reloadData()
                }
            }
            
            
        }
        else
        {
            self.ShowAlertForNetworkNotRechable()
            
        }
        
        
        
    }
    // this function is used for save the new task on server so its accept the name parameter
    func AddTasks(name:String)
    {
        if NetworkFunctions.NetworkRechability()
        {
            DispatchQueue.global(qos: .background).async {
                print("Run on background thread")
                var params : [String:Any]
                params=["name":name]
                
                Alamofire.request(AppURLS.CREATE_TASK_UEL, method: .post, parameters: params, encoding: JSONEncoding.default)
                    .responseJSON { response in
                        debugPrint(response)
                        
                        if response.response!.statusCode==200
                        {
                            if response.result.value != nil{
                                
                                
                                let result = (response.value) as AnyObject
                                
                                let ServerTodo=result.value(forKey: "todo") as AnyObject
                                self.tasks.reverse()
                                self.tasks.append(Tasks(name: name,checked:false,id:Int(ServerTodo["todo_id"] as! String)!))
                                
                                self.tasks.reverse()
                                self.tableView.reloadData()
                                
                            }
                            
                        }
                }
             
                DispatchQueue.main.async {
                    print("We finished that.")
                    // only back on the main thread, may you access UI:
                    self.tableView.reloadData()
                }
            }
            
            
        }
        else
        {
            self.ShowAlertForNetworkNotRechable()
            
        }
        
        
    }
    //this function wil featch all task from the server and list down to the task modal
    func GetAllTasks()
    {
        if NetworkFunctions.NetworkRechability()
        {
            DispatchQueue.global(qos: .background).async {
                print("Run on background thread")
                
                Alamofire.request(AppURLS.TASK_LIST_UEL, method: .get, encoding: JSONEncoding.default)
                    .responseJSON { response in
                        debugPrint(response)
                        
                        if response.response!.statusCode==200
                        {
                            if response.result.value != nil{
                                
                                let result = (response.value) as AnyObject
                                
                                let TaskList=result.value(forKey: "TodoList") as! [AnyObject]
                                print(TaskList)
                                for item in TaskList
                                {
                                    
                                    if  (item["status"] as! Int) == 0
                                    {
                                        self.tasks.append(Tasks(name: item["name"] as! String,checked:false,id:Int(item["todo_id"] as! String)!))}
                                    else
                                    {     self.tasks.append(Tasks(name: item["name"] as! String,checked:true,id:Int(item["todo_id"] as! String)!))}
                                }
                                self.tasks.reverse()
                                self.tableView.reloadData()
                                
                            }
                            
                        }
                }
                DispatchQueue.main.async {
                    print("We finished that.")
                    // only back on the main thread, may you access UI:
                    self.tableView.reloadData()
                }
            }
            
            
        }
        else
        {
            self.ShowAlertForNetworkNotRechable()
            
        }
        
        
    }
    
}

