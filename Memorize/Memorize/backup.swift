//
//  backup.swift
//  Memorize
//
//  Created by Ana Clara Schotte on 26/07/2022.
//

import Foundation


//    @State var emojis = ["🚍", "✈️", "🛳", "🚂", "🦼", "🛴", "🚲", "🛵", "🏍", "🛺", "🚨", "🚘", "🚖", "🚡", "🚠", "🚟", "🚃", "🚋", "🚞", "🚝", "🚅", "🚆", "🚊", "🛩"]
//
//    @State var emojiCount = 17
    
//    var minSize: CGFloat {
//        switch emojiCount {
//        case 0...9:
//           return 90
//        case 10...16:
//           return 68
//        default:
//            return 65
//        }
//
//    }




//            Spacer()
//            bottomMenu
//                .padding()
            
//            HStack {
//                removeButton
//                Spacer()
//                addButton
//            }
//            .font(.largeTitle)
//            .padding(.horizontal)



//    private var bottomMenu: some View {
//        HStack {
//
//            Button {
//                emojiCount = Int.random(in: 8...24)
//                emojis = emojisVehicles.shuffled()
//            } label: {
//                VStack {
//                    Image(systemName: "car")
//                        .font(.largeTitle)
//                    Text("Vehicles")
//                        .font(.caption)
//                }
//            }
//            .padding(.horizontal)
//            Spacer()
//            Button {
//                emojiCount = Int.random(in: 8...16)
//                emojis = emojisActivities.shuffled()
//            } label: {
//                VStack {
//                    Image(systemName: "figure.walk")
//                        .font(.largeTitle)
//                    Text("Activities")
//                        .font(.caption)
//                }
//            }
//            .padding(.horizontal)
//            Spacer()
//            Button {
//                emojiCount = Int.random(in: 8...16)
//                emojis = emojisAnimals.shuffled()
//            } label: {
//                VStack {
//                    Image(systemName: "pawprint")
//                        .font(.largeTitle)
//                    Text("Animals")
//                        .font(.caption)
//                }
//            }
//            .padding(.horizontal)
//        }
//    }
    
//    private var removeButton: some View {
//        Button {
//            if emojiCount > 8 {
//                emojiCount -= 1
//            }
//        } label: {
//            Image(systemName: "minus.circle")
//        }
//
//    }
//
//    private var addButton: some View {
//        Button {
//            if emojiCount < 24 {
//                emojiCount += 1
//            }
//        } label: {
//            Image(systemName: "plus.circle")
//        }
//    }
