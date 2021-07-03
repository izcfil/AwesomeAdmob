//
//  AdmobNativeListener.swift
//  Admob
//
//  Created by An Nguyen on 02/07/2021.
//

import Foundation
import GoogleMobileAds
import AwesomeAdCore

typealias OnAdLoaded = (GADNativeAd) -> Void

class AdmobNativeListener: NSObject, GADNativeAdLoaderDelegate {
    
    private var onLoaded: OnAdLoaded? = nil
    private var onError: OnError? = nil
    
    func setEvents(onLoaded: OnAdLoaded?, onError: OnError?) {
        self.onLoaded = onLoaded
        self.onError = onError
    }
    
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        onLoaded?(nativeAd)
    }
    
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        onError?(error)
    }
}
