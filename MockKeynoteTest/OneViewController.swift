//
//  OneViewController.swift
//  MockKeynoteTest
//
//  Created by 廖冠翰 on 2018/9/30.
//  Copyright © 2018年 廖冠翰. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    public var selectCell: HenryCell?
    
}

//MARK: - Life Cycle
extension OneViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.delegate = self
    }
}

//MARK: - UINavigationControllerDelegate
extension OneViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return operation == .push ? HenryPushTransition() : nil
    }
}

//MARK: - UICollectionViewDataSource
extension OneViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HenryCell", for: indexPath) as! HenryCell
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension OneViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectCell = collectionView.cellForItem(at: indexPath) as? HenryCell

        performSegue(withIdentifier: "PushToTwoVC", sender: nil)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension OneViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
}

