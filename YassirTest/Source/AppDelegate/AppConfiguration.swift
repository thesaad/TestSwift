//
//  AppConfiguration.swift
//  YassirTest
//
//  Created by Saad on 16/09/2024.
//

import Foundation
import ProgressHUD

class AppConfiguration {
    static let shared = AppConfiguration()
    
    init() {
        // Loader
        ProgressHUD.animationType = .circleRippleMultiple
        ProgressHUD.colorBackground = .clear
        ProgressHUD.colorAnimation = .systemBlue
        ProgressHUD.colorProgress = .systemBlue
        ProgressHUD.colorStatus = .clear
    }
}

