//
//  AdmobBannerListener.swift
//  Admob
//
//  Created by An Nguyen on 02/07/2021.
//

import Foundation
import GoogleMobileAds
import AwesomeAdCore

class AdmobBannerListener: NSObject, GADBannerViewDelegate {
    
    private var onAdLoaded: OnAction? = nil
    private var onError: OnError? = nil
    
    func setEvent(loaded: OnAction? = nil, onError: OnError? = nil) {
        self.onAdLoaded = loaded
        self.onError = onError
    }
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        onAdLoaded?()
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        onError?(error)
    }
}
