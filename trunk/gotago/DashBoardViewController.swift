//
//  DashBoardViewController.swift
//  Carousel
//
//  Created by Saurabh Chakraborty on 20/07/16.
//  Copyright © 2016 Intelegencia. All rights reserved.
//

import UIKit

protocol MenuActionDelegate {
    func openSegue(SegueName: String, sender: AnyObject?)
}

class DashBoardViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var nearMeCollectionView: UICollectionView!
    @IBOutlet weak var locationCollectionView: UICollectionView!
    
    @IBOutlet weak var currentUserProfileImageButton: UIButton!
    @IBOutlet weak var currentUserFullNameButton: UIButton!
    
    
    private var interests = Interest.createInterests()
    private var locations = Locations.createLocations()
    
    var window: UIWindow?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let interactor = Interactor()
    
    private func createMenuView() {
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("DashBoardViewController") as! DashBoardViewController
        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("LeftViewController") as! LeftViewController
        //        let rightViewController = storyboard.instantiateViewControllerWithIdentifier("RightViewController") as! RightViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        UINavigationBar.appearance().tintColor = UIColor(hex: "689F38")
        
        leftViewController.mainViewController = nvc
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = mainViewController
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.createMenuView()
    }
    
    @IBAction func openMenu(sender: AnyObject) {
        performSegueWithIdentifier("openMenu", sender: nil)
    }
    
    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .Right)
        
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor) {
                self.performSegueWithIdentifier("openMenu", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationViewController = segue.destinationViewController as? MenuViewController {
            destinationViewController.transitioningDelegate = self
            destinationViewController.interactor = interactor
            destinationViewController.menuActionDelegate = self
         }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.prepareUI()

    }
    
    private struct Storyboard {
        static let CellIdentifier = "Interest Cell"
        static let LocationIdentifier = "Location Cell"
    }
    
    // MARK: prepareVC
    func prepareUI(){
        self.addSearchBar()

    }
    
    func addSearchBar(){

            searchController.searchResultsUpdater = self
            searchController.searchBar.delegate = self
            searchController.searchBar.searchBarStyle       = UISearchBarStyle.Minimal
            searchController.searchBar.backgroundColor      = UIColor.whiteColor()
            searchController.searchBar.tintColor            = UIColor.blackColor()
            searchController.searchBar.delegate             = self;
            searchController.searchBar.placeholder          = "Search";
        
        if !searchController.searchBar.isDescendantOfView(self.view){
            self.view .addSubview(searchController.searchBar)
        }
    }
    
}


extension DashBoardViewController: UIViewControllerTransitioningDelegate {
    func animationContrllerForPresentedController(presented: UIViewController, presentingController presenting:UIViewController, sourceController source:UIViewController) -> UIViewControllerAnimatedTransitioning {
        return PresentMenuAnimator()
    }
    
    func animationControllerForDismissiedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning {
        return DismissMenuAnimator()
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

extension DashBoardViewController : MenuActionDelegate {
    func openSegue(segueName: String, sender: AnyObject?) {
        dismissViewControllerAnimated(true) {
            self.performSegueWithIdentifier(segueName, sender: sender)
        }
    }
}

extension DashBoardViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == nearMeCollectionView {
            return interests.count
        } else {
            return locations.count
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == nearMeCollectionView  {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! InterestCollectionViewCell
            
            cell.interest = self.interests[indexPath.item]
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.LocationIdentifier, forIndexPath: indexPath) as! LocationsCollectionViewCell
            
            cell.location = self.locations[indexPath.item]
            
            return cell
        }
    }
}

extension DashBoardViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension DashBoardViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension DashBoardViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}
