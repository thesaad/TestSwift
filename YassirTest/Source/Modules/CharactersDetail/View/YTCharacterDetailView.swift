//
//  YTCharacterDetailView.swift
//  YassirTest
//
//  Created by Saad on 16/09/2024.
//

import SwiftUI

struct YTCharacterDetailView: View {
    @StateObject var viewModel: YTCharacterDetailViewModel
    init(id: Int) {
        self._viewModel = StateObject(wrappedValue: YTCharacterDetailViewModel(id: id))
    }
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack (alignment: .leading) {
                    if let character = viewModel.character {
                        AsyncImage(url: URL(string: character.image)) { image in
                            image.resizable()
                                .frame(width: geo.size.width, height: geo.size.width)
                                .scaledToFit()
                                .cornerRadius(20)
                        } placeholder: {
                            // Placeholder image untile real images is loaded
                            ProgressView()
                                .frame(width: geo.size.width, height: geo.size.width)
                        }

                        HStack(alignment: .top) {
                            Text(character.name)
                                .font(.ytFont(.bold, size: 20))
                            Spacer()
                            Text("\(character.status)")
                                .frame(height: 20)
                                .foregroundStyle(.black)
                                .font(.ytFont(.regular, size: 12))
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(character.status.fillColor)
                                        .stroke(character.status.borderColor)
                                        .frame(width: 60)

                                )
                                .padding(.trailing, 20)

                            
                        }
                        .padding(.horizontal, 20)
                        HStack {
                            Text(character.origin?.name ?? "NA")
                                .font(.ytFont(.regular, size: 16))
                                .foregroundStyle(Color.ytIndigo)
                                .onTapGesture {
                                    // open url for origin
                                }
                            Text("●")
                                .foregroundStyle(Color.ytIndigo)
                            
                            Text(character.gender)
                                .font(.ytFont(.regular, size: 16))
                                .foregroundStyle(Color.ytLightIndigo)

                        }
                        .padding(.horizontal, 20)               
                        HStack {
                            Text("Location: ")
                                .font(.ytFont(.regular, size: 16))
                                .foregroundStyle(Color.ytDarkIndigo)
                            Text(character.location?.name ?? "NA")
                                .font(.ytFont(.regular, size: 16))
                                .foregroundStyle(Color.ytIndigo)
                        }
                        .padding(.horizontal, 20)
                        .onTapGesture {
                            //Open Location url
                        }

                    }
                }
            }

        }

    }
}

#Preview {
    YTCharacterDetailView(id: 1)
}
