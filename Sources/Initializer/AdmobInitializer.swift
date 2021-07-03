//
//  AdmobInitializer.swift
//  Admob
//
//  Created by An Nguyen on 02/07/2021.
//

import Foundation
import GoogleMobileAds

public class AdmobInitializer {
    
    public static func initializer() {
        GADMobileAds.sharedInstance().start { status in
            let adapterStatuses = status.adapterStatusesByClassName
            for adapter in adapterStatuses {
                let adapterStatus = adapter.value
                debugPrint("Adapter Name: %@, Description: %@, Latency: %f", adapter.key,
                      adapterStatus.description, adapterStatus.latency)
            }
        }
    }
}
