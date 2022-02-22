//
//  ViewController.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 25/01/22.
//

import UIKit

class OnboardingVC: UIViewController {

    @IBOutlet weak var slidingCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!
    
    var slides:[OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet{
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Done", for: .normal)
            }else{
                nextBtn.setTitle("Next", for: .normal)
            }
            pageControl.currentPage = currentPage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [
            OnboardingSlide(title: "Delicious Dishes", description: "Experience a variety of amazing dishes from different cultures around the world.", image: #imageLiteral(resourceName: "slide2")),
            OnboardingSlide(title: "World-Class Chefs", description: "Our dishes are prepared by only the best.", image: #imageLiteral(resourceName: "slide1")),
            OnboardingSlide(title: "Instant World-Wide Delivery", description: "Your orders will be delivered instantly irrespective of your location around the world.", image: #imageLiteral(resourceName: "slide3"))
        ]
        
        //Adding page count based on I/P data
        pageControl.numberOfPages = slides.count
        /*//Uncomment below code if they are not connected in storyboard.
         slidingCollectionView.delegate = self
         slidingCollectionView.dataSource = self
         */
        
    }

    @IBAction func clickedNextBtn(_ sender: Any) {
        //Check the last screen and navigate to home screen
        if currentPage == slides.count - 1 {
            
            let homeVC = storyboard?.instantiateViewController(withIdentifier: "homeNC") as! UINavigationController
            homeVC.modalPresentationStyle = .fullScreen
            homeVC.modalTransitionStyle = .flipHorizontal
            UserDefaults.standard.hasOnboarded = true
            present(homeVC, animated: true, completion: nil)
            
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            slidingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
    }
    
}

//MARK:- Extension CollectionView
extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = slidingCollectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCVCell.identifier, for: indexPath) as? OnboardingCVCell else {return UICollectionViewCell()}
        cell.setUp(slides[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    //Change the PageControl & scrolling behavior of collection view
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
    }
    
}

