//
//  AdmobFullscreenContentCallback.swift
//  MangaReader
//
//  Created by An Nguyen on 01/07/2021.
//  Copyright © 2021 AwesomeCompany. All rights reserved.
//

import Foundation
import GoogleMobileAds
import AwesomeAdCore

class AdmobFullscreenContent: NSObject, GADFullScreenContentDelegate {
    
    private var onDismiss: OnAction? = nil
    
    private var onFailedToShow: OnError? = nil
    
    func setupEvent(onDismiss: OnAction?, onFailed: OnError?) {
        self.onDismiss = onDismiss
        self.onFailedToShow = onFailed
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        self.onDismiss?()
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        self.onFailedToShow?(error)
    }
}

