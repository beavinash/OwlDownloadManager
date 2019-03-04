//
//  ViewController.swift
//  DownloadManager
//
//  Created by Mei Yu on 11/12/18.
//  Copyright © 2018 725-1 Corporation. All rights reserved.
//

import UIKit
import MockService
import Foundation

class OwlServiceViewController: UIViewController {
    
    //MARK: - Properties
    
    // service object initalization for Singleton access.
    let service: UnpredictableSlowService = UnpredictableSlowService.shared
    
    @IBOutlet weak var tableView: UITableView!
    
    // Properties for storing metadata and result data
    var dataMetaArray = [String]()
    var resultFetchArrayData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Background process in a pool of threads i.e. managed by Grand Central Dispatch.
        DispatchQueue.global(qos: .background).async {
            
            // Function call for fetching meta data with a response data from a Singleton class.
            self.service.fetchMetaData { (data) in
                // Add data to a local variable.
                if let data = data {
                    self.dataMetaArray = data
                }
            }
            
            
            // Update of UI starts here on a main thread.
            for key in self.dataMetaArray {
                // Function call for fetching data based on the give key with a response data from a Singleton class.
                self.service.fetch(key: key, completion: { (data) in
                    // Main Thread execution for display of data in a TableView.
                    DispatchQueue.main.async {
                        // Add data to a local variable.
                        self.resultFetchArrayData.append(data)
                        self.tableView.reloadData()
                    }
                })
                
            }
            
        }
    }


}

extension OwlServiceViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Displays number of rows based on the requirements of the result
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultFetchArrayData.count
    }
    
    // Displays data in a UITableViewCell based on a index value of cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and is dequeued using a cell identifier.
        let cellIdentifier = "DataTableViewCell"
        
        // Condtion to check if the deque cell has a instance
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? OwlTableViewCell  else {
            fatalError("The dequeued cell is not an instance of OwlTableViewCell.")
        }
        
        // Fetches the appropriate data for the data source layout in a TableView.
        let data = resultFetchArrayData[indexPath.row]
        
        // Display data in a UITableViewCell.
        cell.dataCellLabel.text = data
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     //MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
