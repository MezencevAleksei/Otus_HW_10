//
//  FeedViewController.swift
//  Otus_HW_3
//
//  Created by alex on 15/06/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: nil)
    private var testResult: [String : Double]?
    private var testTime: Double?
    @IBOutlet var tableView: UITableView!
    
    private var feedDataProvider:FeedDataProvider = {
        if let service: FeedDataProvider = ServiceLocator.shared.getService() {
            return service
        } else {
            fatalError()
        }
    }()
    var filteredFeedData = [FeedData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Тест", style: .plain, target: self, action: #selector(startTest))
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search algorithm"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeedTableViewCell.nib, forCellReuseIdentifier: FeedTableViewCell.reuseID)
    }
}




 //MARK: Extension for Test
 //UISearchController
 extension FeedViewController  {
    
    @objc func startTest(){
        let sheduler = Sheduler()
        let count = 10000
     
        
        //Уменшим количество тк SuffixArray создается крайне медлено (возможно что то не так в реализации)
        let queueSuffixArray = JobQueue(jobs: [{
            _ = SuffixArrayManipulator().setupWithObjectCount(count/10)
            }])
        sheduler.addJobQueue(queue: queueSuffixArray, nameQueue: "SuffixArray")
        
        
 
        let queueSwiftArray = JobQueue(jobs: [{
            _ = SwiftArrayManipulator().setupWithObjectCount(count)
            }])
        sheduler.addJobQueue(queue: queueSwiftArray, nameQueue: "Array")
        
        
        let queueDictionary = JobQueue(jobs: [{
            _ = SwiftDictionaryManipulator().setupWithEntryCount(count)
            }])
        sheduler.addJobQueue(queue: queueDictionary, nameQueue: "Dictionary")
       
         
        let queueSet = JobQueue(jobs: [{
            _ = SwiftSetManipulator().setupWithObjectCount(count)
            }])
        sheduler.addJobQueue(queue: queueSet, nameQueue: "Set")
        
        sheduler.start(){
             self.testResult = sheduler.getResult()
             self.testTime = sheduler.timeOfWork
             DispatchQueue.main.async {
                 self.tableView.reloadData()
             }
        }
        
    }
}
    
    
//MARK: Extension
//UISearchController
extension FeedViewController: UISearchResultsUpdating  {
   
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text{
            filterContentForSearchText(text)
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        if searchText.count > 0 {
            filteredFeedData = feedDataProvider.findFeedDataByFeedName(searchText)
        }
        tableView.reloadData()
    }
    
    //search in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredFeedData.count
        }
        return feedDataProvider.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseID, for: indexPath) as? FeedTableViewCell else {
            fatalError("Bad cell")
        }
        
        if isFiltering() {
            if indexPath.row <= filteredFeedData.count - 1 {
                let itemText = filteredFeedData[indexPath.row]
                cell.update(labelText: itemText.name)
            }
        } else {
            if let itemText = feedDataProvider.itemFor(index: indexPath.row){
                cell.update(labelText: itemText.name)
            }
        }
        
        //Установим время теста и цвет ячейки в зависимости от результатат теста
        if let name = cell.itemLabel.text {
            if let _testResult = self.testResult{
                if let curentTestResult = _testResult[name] {
                    let color = UIColor().getColorOfProcent(curentTestResult*100)
                    cell.setBackgroundColor(color: color)
                    if let _testTime = self.testTime{
                        cell.setTimeOfTest(time: curentTestResult * _testTime)
                    }
                }
            }
        }
        
        return cell
        
    }

}


//UITableView
extension FeedViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc: UIViewController?
        
        if let currentCell = tableView.cellForRow(at: indexPath) as? FeedTableViewCell, let name = currentCell.itemLabel.text {
            switch name {
                case "SuffixArray":
                    let storyboard = UIStoryboard(name: "DataStructuresSuffixArray", bundle: nil)
                    vc = storyboard.instantiateViewController(withIdentifier: "SuffixArrayViewController")
                case "Array":
                    let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                    vc = storyboard.instantiateViewController(withIdentifier: "ArrayViewController")
                case "Set":
                    let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                    vc = storyboard.instantiateViewController(withIdentifier: "SetViewController")
                case "Dictionary":
                    let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                    vc = storyboard.instantiateViewController(withIdentifier: "DictionaryViewController")
                default:
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    vc = storyboard.instantiateViewController(withIdentifier: "SessionSummaryViewController")
                }
            }

        if let pushViewController = vc {
            self.navigationController?.pushViewController(pushViewController, animated: true)
        }
        
    }
    
}

