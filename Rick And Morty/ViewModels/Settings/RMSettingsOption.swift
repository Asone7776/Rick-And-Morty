//
//  RMSettingsOption.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 31/03/23.
//

import UIKit

enum RMSettingsOption: CaseIterable{
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    var displayTitie: String{
        switch self {
        case .rateApp:
            return "Rate app"
        case .contactUs:
            return "Contact us"
        case .terms:
            return "Terms of service"
        case .privacy:
            return "Privacy policy"
        case .apiReference:
            return "API Reference"
        case .viewSeries:
            return "View video series"
        case .viewCode:
            return "View app code"
        }
    }
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane.fill")
        case .terms:
            return UIImage(systemName: "doc.fill")
        case .privacy:
            return UIImage(systemName: "lock.fill")
        case .apiReference:
            return UIImage(systemName: "list.clipboard.fill")
        case .viewSeries:
            return UIImage(systemName: "video.fill")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
    var iconContainerColor:UIColor{
        switch self {
        case .rateApp:
            return .systemBlue
        case .contactUs:
            return .systemRed
        case .terms:
            return .systemYellow
        case .privacy:
            return .systemPink
        case .apiReference:
            return .systemPurple
        case .viewSeries:
            return .systemGreen
        case .viewCode:
            return .systemCyan
        }
    }
    var url: URL?{
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://iosacademy.io/contact/")
        case .terms:
            return URL(string: "https://iosacademy.io/terms/")
        case .privacy:
            return URL(string: "https://iosacademy.io/privacy/")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/")
        case .viewSeries:
            return URL(string: "https://www.youtube.com/playlist?list=PL5PR3UyfTWvdl4Ya_2veOB6TM16FXuv4y")
        case .viewCode:
            return URL(string: "https://github.com/Asone7776/Rick-And-Morty")
        }
    }
}
