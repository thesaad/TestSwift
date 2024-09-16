//
//  YTCharacterRow.swift
//  YassirTest
//
//  Created by Saad on 13/09/2024.
//

import SwiftUI


/// A swiftui view representing character row in tableviewcell
///
struct YTCharacterRow: View {
    
    /// Data to be displayed on view,
    var character: YTCharacter
    
    /// View boday render,
    var body : some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(character.status.fillColor)
                .stroke(character.status.borderColor)
            HStack (alignment: .top){
                // To provide a lazy loading of image.
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                        .frame(width: 80, height: 80)
                        .scaledToFit()
                        .cornerRadius(12)
                } placeholder: {
                    // Placeholder image untile real images is loaded
                    ProgressView()
                        .frame(width: 80, height: 80)
                        .cornerRadius(12)
                }
                
                VStack(alignment: .leading) {
                    Text(character.name)
                        .font(.ytFont(.bold))
                        .foregroundStyle(.black)
                        .padding(.top, 5)
                        .padding(.leading, 5)

                    Text(character.species)
                        .font(.ytFont(.regular, size: 14))
                        .foregroundStyle(.gray)
                        .padding(.top, 5)
                        .padding(.leading, 5)
                    
                }
            }
            .padding()

        }
    }
}

#Preview {
    YTCharacterRow(character: .mockCharacter)
}
