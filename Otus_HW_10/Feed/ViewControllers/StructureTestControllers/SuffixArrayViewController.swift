//
//  SuffixArrayViewController.swift
//  Otus_HW_4
//
//  Created by alex on 14/07/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//
private enum ArrayVCRow: Int {
    case
    creation = 0,
    insertNewObject,
    lookupByObject,
    lookupBy10RandomeString,
    lookupAllAlgo,
    lookupForSpecifiedNumber
}

import UIKit



class SuffixArrayViewController: DataStructuresViewControllerSuffixArray {

   
    //MARK: - Variables
    var countOfFindedElement:Int = 5
    let suffixArrayManipulator: SuffixArrayManipulator = SuffixArrayManipulator()
    var creationTime: TimeInterval = 0
    var insertNewObject: TimeInterval = 0
    var lookupByObject: TimeInterval = 0
    var lookupBy10RandomeString: TimeInterval = 0
    var lookupAllAlgo: TimeInterval = 0
    var lookupForSpecifiedNumber: TimeInterval = 0
    
    
    //MARK: - Methods
    
    @IBAction func countOfFindedElementDidChange(_ sender: Any) {
        if let countTest = (sender as! UITextField).text {
            if let countNumb = Int(countTest) {
                countOfFindedElement = countNumb
            }
        }
    }
    
    //MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBehaviors(behaviors: [ViewControllerDataCaching()])
        createAndTestButton.setTitle("Create Suffix Array and Test", for: [])
    }
    
    @IBAction func testWithSpecifiedNumber(_ sender: Any) {
        
    }
    
    private func testLookupForSpecifiedNumber(){
        lookupForSpecifiedNumber = suffixArrayManipulator.lookupForSpecifiedNumber(countOfFindedElement)
 
    }
    
    //MARK: Superclass creation/testing overrides
    
    override func create(_ size: Int) {
        creationTime = suffixArrayManipulator.setupSuffixArray()
    }
    
    
    
    override func test() {
        if (suffixArrayManipulator.arrayHasObjects()) {
            
            insertNewObject = suffixArrayManipulator.insertNewObject()
            lookupByObject = suffixArrayManipulator.lookupByObject()
            lookupBy10RandomeString = suffixArrayManipulator.lookupBy10RandomeString()
            lookupAllAlgo = suffixArrayManipulator.lookupAllAlgo()
            testLookupForSpecifiedNumber()
        } else {
            print("Array not set up yet!")
        }
    }
    
    //MARK: Table View Override
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        switch (indexPath as NSIndexPath).row {
        case ArrayVCRow.creation.rawValue:
            cell.textLabel!.text = "Suffix Array Creation:"
            cell.detailTextLabel!.text = formattedTime(creationTime)
        case ArrayVCRow.insertNewObject.rawValue:
            cell.textLabel!.text = "Insert New Object"
            cell.detailTextLabel!.text = formattedTime(insertNewObject)
        case ArrayVCRow.lookupByObject.rawValue:
            cell.textLabel!.text = "Lookup By Object:"
            cell.detailTextLabel!.text = formattedTime(lookupByObject)
        case ArrayVCRow.lookupBy10RandomeString.rawValue:
            cell.textLabel!.text = "Lookup By 10 Randome String:"
            cell.detailTextLabel!.text = formattedTime(lookupBy10RandomeString)
        case ArrayVCRow.lookupAllAlgo.rawValue:
            cell.textLabel!.text = "Lookup All Name Of Algorithm:"
            cell.detailTextLabel!.text = formattedTime(lookupAllAlgo)
        case ArrayVCRow.lookupForSpecifiedNumber.rawValue:
            cell.textLabel!.text = "Lookup For Specified Numbers:"
            cell.detailTextLabel!.text = formattedTime(lookupForSpecifiedNumber)
        default:
            print("Unhandled row! \((indexPath as NSIndexPath).row)")
        }
        
        return cell
    }


}
