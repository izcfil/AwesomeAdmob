//
//  AdmobNative.swift
//  Admob
//
//  Created by An Nguyen on 02/07/2021.
//

import Foundation
import GoogleMobileAds
import AwesomeAdCore

public class AdmobNative: NativeAdItem<GADNativeAd> {
    private var adContainer: GADNativeAdView? = nil
    private var adLoader: GADAdLoader!
    private lazy var listener: AdmobNativeListener = {
        AdmobNativeListener()
    }()
    
    public init(_ id: String, rootViewController: UIViewController?) {
        super.init(id)
        adLoader = GADAdLoader(adUnitID: id, rootViewController: rootViewController, adTypes: [.native], options: [])
    }
    
    public override func load(onLoaded: @escaping OnAction, onError: @escaping OnError) {
        listener.setEvents(onLoaded: { [weak self] nativeAd in
            self?.ad = nativeAd
            onLoaded()
        }, onError: onError)
        adLoader.delegate = listener
        adLoader.load(GADRequest())
    }
    
    public override func getAdContainer() -> UIView {
        if adContainer == nil {
            adContainer = GADNativeAdView(frame: .zero)
            adContainer?.translatesAutoresizingMaskIntoConstraints = false
        }
        return adContainer!
    }
    
    public override func setHeadlineView(_ view: UILabel) {
        view.text = ad?.headline
        adContainer?.headlineView = view
    }
    
    public override func setBodyView(_ view: UILabel) {
        view.text = ad?.body
        adContainer?.bodyView = view
    }
    
    public override func setCallToActionView(_ view: UIButton) {
        view.setTitle(ad?.callToAction, for: .normal)
        adContainer?.callToActionView = view
        adContainer?.callToActionView?.isUserInteractionEnabled = false
    }
    
    public override func setMediaView(_ view: UIView) {
        let mediaView = GADMediaView(frame: view.bounds)
        view.addSubview(mediaView)
        adContainer?.mediaView = mediaView
        adContainer?.mediaView?.mediaContent = ad?.mediaContent
    }
    
    public override func setIconView(view: UIImageView) {
        view.image = ad?.icon?.image
        adContainer?.iconView = view
    }
    
    public override func onFinalizeAd() {
        adContainer?.nativeAd = ad
    }
}
