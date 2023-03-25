//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  Rick And Morty
//
//  Created by Uzkassa on 24/03/23.
//

import UIKit
final class RMCharacterInfoCollectionViewCellViewModel{
    private let value:String
    private let fieldType: FieldType
    
    static let customDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter;
    }();
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter;
    }();
    
    public var title: String {
        self.fieldType.displayTitle
    }
    
    public var displayValue: String{
        if value.isEmpty{
            return "No data"
        }else{
            guard let date = Self.customDateFormatter.date(from: value), fieldType == .created else {
                return value;
            }
            return Self.shortDateFormatter.string(from: date);
        }
    }
    
    public var displayIconName: String{
        self.fieldType.displayIcon;
    }
    
    public var tintColor: UIColor{
        self.fieldType.tintColor;
    }
    enum FieldType:String{
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodes
        
        var tintColor: UIColor{
            switch self{
            case .status:
                return .systemBlue
            case .gender:
                return .systemRed
            case .type:
                return .systemGray
            case .species:
                return .systemGreen
            case .origin:
                return .systemYellow
            case .created:
                return .systemPurple
            case .location:
                return .systemPink
            case .episodes:
                return .systemTeal
            }
        }
        var displayIcon: String{
            switch self{
            case .status:
                return "bell";
            case .gender:
                return "person";
            case .type:
                return "bell";
            case .species:
                return "bell";
            case .origin:
                return "bell";
            case .created:
                return "bell";
            case .location:
                return "globe";
            case .episodes:
                return "bell";
            }
        }
        var displayTitle: String{
            switch self{
            case .status:
                return "Status";
            case .gender:
                return "Gender";
            case .type:
                return "Type";
            case .species:
                return "Species";
            case .origin:
                return "Origin";
            case .created:
                return "Created";
            case .location:
                return "Location";
            case .episodes:
                return "Episodes count";
            }
        }
    }
    init(value:String,type: FieldType){
        self.value = value
        self.fieldType = type;
    }
}
