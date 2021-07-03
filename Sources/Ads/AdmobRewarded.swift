//
//  AdmobRewarded.swift
//  Admob
//
//  Created by An Nguyen on 02/07/2021.
//

import Foundation
import AwesomeAdCore
import GoogleMobileAds

public class AdmobRewarded: RewardAd<GADRewardedAd> {
    
    private lazy var listener: AdmobFullscreenContent = {
       AdmobFullscreenContent()
    }()
    
    public override func show(from viewController: UIViewController, onReward: OnAction?, onDismiss: OnAction?, onFailedToShow: OnError?) {
        listener.setupEvent(onDismiss: onDismiss, onFailed: onFailedToShow)
        ad?.fullScreenContentDelegate = listener
        ad?.present(fromRootViewController: viewController, userDidEarnRewardHandler: {
            onReward?()
        })
    }
    
    public override func load(onLoaded: @escaping OnAction, onError: @escaping OnError) {
        GADRewardedAd.load(withAdUnitID: id, request: GADRequest()) { [weak self] ad, error in
            if let error = error {
                debugPrint(error)
                onError(error)
                return
            }
            self?.ad = ad
            onLoaded()
        }
    }
}
