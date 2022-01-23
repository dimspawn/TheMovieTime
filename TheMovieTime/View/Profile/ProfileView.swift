//
//  ProfileView.swift
//  TheMovieTime
//
//  Created by Dimas Wicaksono on 14/12/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
                ScrollView(.vertical, showsIndicators: false){
                    ZStack {
                        VStack {
                            VStack {
                                profileImage
                                profileName
                                profileEmail
                                profileAddress
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.movieCard)
                        .cornerRadius(20)
                    }.padding(8)
                }
            
        }
        .background(Color.movieBackground)
            .navigationBarTitle("Profile", displayMode: .inline)
    }
}

extension ProfileView {
    @ViewBuilder
    var profileImage: some View {
        Image("foto_dimas-circle")
            .resizable()
            .scaledToFit()
            .frame(width: 130)
            .padding(50)
    }
    
    var profileName: some View {
        Text("Dimas Panuji Wicaksono")
            .font(.title)
            .bold()
            .foregroundColor(Color.movieFont)
    }
    
    var profileEmail: some View {
        Text("myzrael005@gmail,com")
            .foregroundColor(Color.movieFont)
    }
    
    var profileAddress: some View {
        Text("Lampung, Indonesia")
            .font(.title2)
            .bold()
            .padding(30)
            .foregroundColor(Color.movieFont)
    }
}
