//
//  BenchmarkViewController.swift
//  Otus_HW_2
//
//  Created by alex on 09/06/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import UIKit

class BenchmarkViewController: UIViewController {
 
    
    private let benchmarkViewModel = BenchmarkViewModel()
    
    private var layouts = [StagLayout]()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomeTimerView.nib, forCellWithReuseIdentifier: CustomeTimerView.reuseID)
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Update layout", style: .plain, target: self, action: #selector(changeLayout))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update PieCharts", style: .plain, target: self, action: #selector(updatePieChartInVisibleCell))
    }
    
    @objc func changeLayout() {
        collectionView.setCollectionViewLayout(benchmarkViewModel.getLayout(), animated: true)
        updateVisibleCell()
    }
    
    @objc func updatePieChartInVisibleCell() {
        updateVisibleCell()
    }
    
    private func updateVisibleCell(){
        for cell in collectionView.visibleCells {
            (cell as! CustomeTimerView).update()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let timerCell = collectionView.cellForItem(at: indexPath)
        (timerCell as! CustomeTimerView).didSelected()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        for timerModel in benchmarkViewModel.TimerModels {
            if let cell = collectionView.cellForItem(at: timerModel.key){
                (cell as! CustomeTimerView).removeTimer()
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        for timerModel in benchmarkViewModel.TimerModels {
            timerModel.value.initTimer()
        }
    }
}

extension BenchmarkViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return benchmarkViewModel.getCountOfItemInCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard var timerCell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomeTimerView.reuseID, for: indexPath) as? CustomeTimerView else {
                fatalError("Bad cell")
            }
        benchmarkViewModel.setupeCell(timerCell: &timerCell, at: indexPath)
        timerCell.update()
        return timerCell
    }
}
