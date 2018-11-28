//
//  AddTaskController.swift
//  todoList
//
//  Created by rishad k on 27/11/18.
//  Copyright © 2018 rishad k. All rights reserved.
//

import UIKit

protocol AddTask {
    func addTask(name: String,index:Int,edit:Bool)
}



class AddTaskController: UIViewController {
    var index:Int=Int()
    var name:String = String()
    //edit varable is used for checking its an edit action or new task saving
    var edit:Bool=Bool()
    @IBAction func addAction(_ sender: Any) {
        //checking if the textbox is empty or not if its empty then show the alert .if its not empty the it will call the delegate function and save it on server
        if nameTextField.text != "" {
            //one button doing to task for new task saving and updating an existing task so we are keeping edit carable if its true the its an edit action or else its an new task to store
            if edit
            {
                
                delegate?.addTask(name: nameTextField.text!,index:index,edit:true)
                navigationController?.popViewController(animated: true)
            }
            else
            {
                
                delegate?.addTask(name: nameTextField.text!,index:index,edit:false)
                navigationController?.popViewController(animated: true)
            }
            
        }
        else
        {
            let alert = UIAlertController(title: "Warning", message: "field 'task name' must be filled", preferredStyle: .alert)
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
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var delegate: AddTask?
    
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var labelCaption: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //edit varable is used for checking its an edit action or new task saving
        if edit
        {
            nameTextField.text=name
            buttonSave.setTitle("Update", for: .normal)
            labelCaption.text="Update task"
        }
    }
}
