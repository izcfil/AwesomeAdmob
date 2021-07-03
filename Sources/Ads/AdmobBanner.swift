//
//  AdmobBanner.swift
//  Admob
//
//  Created by An Nguyen on 02/07/2021.
//

import Foundation
import AwesomeAdCore
import GoogleMobileAds

public class AdmobBanner: BannerAd<GADBannerView> {
    
    private var viewWidth: CGFloat = 0
    private lazy var listener = {
       AdmobBannerListener()
    }()
    
    public init(_ id: String, rootViewController: UIViewController, adSize: GADAdSize? = nil) {
        super.init(id)
        calculateViewWidth(rootViewController.view)
        ad = GADBannerView(adSize: adSize ?? getBannerSize())
        setRootViewController(rootViewController)
        ad?.adUnitID = id
    }
    
    public override init(_ id: String) {
        super.init(id)
        ad = GADBannerView(adSize: getBannerSize())
        ad?.adUnitID = id
    }
    
    public func setRootViewController(_ rootViewController: UIViewController) {
        ad?.rootViewController = rootViewController
    }
    
    public func calculateViewWidth(_ rootView: UIView) {
        let frame = { () -> CGRect in
              // Here safe area is taken into account, hence the view frame is used
              // after the view has been laid out.
              if #available(iOS 11.0, *) {
                return rootView.frame.inset(by: rootView.safeAreaInsets)
              } else {
                return rootView.frame
              }
            }()
        viewWidth = frame.size.width
    }
    
    public override func load(onLoaded: @escaping OnAction, onError: @escaping OnError) {
        listener.setEvent(loaded: onLoaded, onError: onError)
        ad?.delegate = listener
        ad?.load(GADRequest())
    }
    
    private func getBannerSize() -> GADAdSize {
        if (viewWidth > 0) {
            return GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        } else {
            return kGADAdSizeBanner
        }
    }
    
    func getBannerHeight() -> CGFloat {
        return ad?.adSize.size.height ?? 50
    }
    
    public override func release() {
        
    }
    
    public static func createAdSize(width: CGFloat, height: CGFloat) -> GADAdSize {
        return GADAdSizeFromCGSize(CGSize(width: width, height: height))
    }
    
}
