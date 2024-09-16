//
//  YTCharacterTableViewCell.swift
//  YassirTest
//
//  Created by Saad on 16/09/2024.
//

import UIKit
import SwiftUI

final class YTCharacterTableViewCell: UITableViewCell {
    
    // MARK: Cell Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Datamanipulation
    /// This will reset previous configuration to nil so that cell is reused and hidden cells don't create memory overhead
    override func prepareForReuse() {
        super.prepareForReuse()
        self.contentConfiguration = nil

    }
    /// We have fresh cell and can simply set swiftUI view to it
    func setItem(character: YTCharacter) {
        
        // We using UIHostingConfiguration to show SwiftUI view in UIKit Cell
        self.contentConfiguration = UIHostingConfiguration(content: {
            YTCharacterRow(character: character)
        })
    }
}


