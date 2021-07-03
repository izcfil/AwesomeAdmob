//
//  AdmobInterstitial.swift
//  Admob
//
//  Created by An Nguyen on 01/07/2021.
//

import Foundation
import UIKit
import GoogleMobileAds
import AwesomeAdCore

public class AdmobInterstitial: InterstitialAd<GADInterstitialAd> {

    private lazy var adShowListener: AdmobFullscreenContent = {
        AdmobFullscreenContent()
    }()
    
    public override func load(onLoaded: @escaping OnAction, onError: @escaping OnError) {
        GADInterstitialAd.load(withAdUnitID: id, request: GADRequest()) {
            [weak self] (ad, error) in
            if let error = error {
                onError(error)
                return
            }
            self?.ad = ad
            onLoaded()
        }
    }
    
    public override func show(from viewController: UIViewController, onDismiss: OnAction? = nil, onFailedToShow: OnError? = nil) {
        adShowListener.setupEvent(onDismiss: onDismiss, onFailed: onFailedToShow)
        ad?.fullScreenContentDelegate = adShowListener
        ad?.present(fromRootViewController: viewController)
    }
}


