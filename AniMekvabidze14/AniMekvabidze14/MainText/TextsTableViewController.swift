//
//  NotesTableViewController.swift
//  AniMekvabidze14
//
//  Created by Mac User on 5/18/21.
//

import UIKit

class TextsTableViewController: UITableViewController, EditTextDelegate {

    @IBAction func onAddButton(_ sender: UIBarButtonItem) {
        let text = ["title": "Title", "body": ""]
        texts.insert(text, at: 0)
        self.tableView.reloadData()
        self.selectedIndex = 0
        performSegue(withIdentifier: "ShowEditScreenSegue", sender: nil)
    }
    
    var texts = [[String:String]]()
    var selectedIndex = -1

    @IBAction func onEdit(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        sender.title = self.tableView.isEditing ? "Done" : "Edit"
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.readTexts()

    }
    
    

// extensions დაწერა არ დამჭირდა რადგანაც Table View Controller მქონდა შექმნილი

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.texts.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath)
        cell.textLabel?.text = self.texts[indexPath.row]["title"]
        return cell
    }
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "ShowEditScreenSegue", sender: nil)
    }
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as? EditViewController
        
        destinationVc?.navigationItem.title = self.texts[selectedIndex]["title"]
        destinationVc?.textBody =  self.texts[selectedIndex]["body"]
        destinationVc?.editTextDelegate = self
        
    }

    func updateText(updatedTitle: String, updatedBody: String) {
        self.texts[selectedIndex]["title"] = updatedTitle
        self.texts[selectedIndex]["body"] = updatedBody
        self.tableView.reloadData()
        self.saveTexts()

    }
    
    
    // DELETE
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.texts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.saveTexts()
        }
    }
    
    // REARRANGE
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = texts[sourceIndexPath.item]
        self.texts.remove(at: sourceIndexPath.item)
        self.texts.insert(movedItem, at: destinationIndexPath.item)
        self.saveTexts()

    }
    
    
    // function რომ აპლიკაციის გამორთვის შემდეგ დასეივდეს რაც მომხმარებელმა ჩაწერა
    func saveTexts(){
        
        UserDefaults.standard.setValue(self.texts, forKey: "notes")
        UserDefaults.standard.synchronize()

    }
    
    func readTexts(){
        
        if let  newTexts = UserDefaults.standard.array(forKey: "notes") as? [[String:String]] {
            self.texts = newTexts
             
        }
    }
    
    

}
