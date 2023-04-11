//
//  OnboardingViewController.swift
//  BusTicket
//
//  Created by Batuhan Demircioğlu on 1.04.2023.
//

import UIKit
import CoreLocation
class OnboardingViewController: UIViewController {
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let locationManager = CLLocationManager()
    var slides: [OnboardingSlide] = []
    var isLaunchedBefore: Bool!
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Başlayalım !", for: .normal)
            } else {
                nextButton.setTitle("Sonraki", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        slides = [OnboardingSlide(title: "Otobüs Bileti Almak Hiç Bu Kadar Kolay Olmamıştı!", description: "Tek yapmanız gereken seyahat tarihlerinizi seçmek ve gideceğiniz nokteleri belirlemek. Geri kalan her şeyi uygulamamız hallediyor!", image: "bus"),OnboardingSlide(title: "Hızlı ve Güvenli Online Ödeme İşlemleri", description: "Saniyeler içinde ödeme yapabilirsiniz. Tüm ödemeleriniz güvenli bir şekilde işlenir ve hiçbir kişisel bilgi üçüncü taraflarla paylaşılmaz.", image: "payment"),OnboardingSlide(title: "İndirimli Fiyatlarla Yolculuk Keyfi", description: "Kuponlarla, yolculuklarınızı daha ucuza yapabilirsiniz. Uygulamamızdaki fırsatları takip ederek daha da fazla indirim kazanabilirsiniz.", image: "coupon")]
        
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse:
                print("Location authorization granted.")
            case .denied, .restricted:
                print("test")
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            default:
                break
            }
        }
    }
    
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        if currentPage == slides.count - 1 {
            
            isLaunchedBefore = true
            UserDefaults.standard.set(isLaunchedBefore, forKey: "isLaunched")
            
            let controller = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            present(controller, animated: true)
            
        } else {
            currentPage += 1
            let index = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
        
    }
    @IBAction func skipButtonTapped(_ sender: Any) {
        isLaunchedBefore = true
        UserDefaults.standard.set(isLaunchedBefore, forKey: "isLaunched")
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true)
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
    
}
