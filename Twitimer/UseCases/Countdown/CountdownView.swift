//
//  CountdownView.swift
//  Twitimer
//
//  Created by Brais Moure on 22/4/21.
//

import SwiftUI

struct CountdownView: View {
    
    // Properties
    
    @ObservedObject var viewModel: CountdownViewModel
    
    // Body
    
    var body: some View {
        ZStack {
            VStack(spacing: Size.none.rawValue) {
                
                // Header
                
                VStack(alignment: .leading, spacing: Size.none.rawValue) {                    
                    
                    if viewModel.streamings.isEmpty {
                        
                        // Info
                        
                        viewModel.infoView()
                        
                    } else {
                        
                        // List
                        
                        Text(viewModel.upcomingText).font(size: .head).foregroundColor(.textColor).padding(Size.medium.rawValue)

                        List {
                            ForEach(viewModel.streamings, id: \.streamer.id) { streaming in
                                ZStack {
                                    NavigationLink(destination: UserRouter.readOnlyView(user: streaming.streamer)) {}.opacity(0)
                                    TimerRowView(streaming: streaming, endDate:
                                                    streaming.schedule.date)
                                }.listRowInsets(EdgeInsets()).background(Color.backgroundColor)
                            }
                        }
                    }
                }.background(Color.secondaryBackgroundColor)
                .cornerRadius(Size.big.rawValue, corners: [.topRight, .topLeft])
                .shadow(radius: Size.verySmall.rawValue)
                .padding(.top, Size.medium.rawValue)
                
                // Buttons
                
                HStack(spacing: Size.medium.rawValue) {
                    
                    MainButton(text: viewModel.updateText, action: {
                        viewModel.reload()
                    }, type: .secondary)
                    
                }.padding(Size.medium.rawValue)
                .background(Color.backgroundColor)
                .shadow(radius: Size.verySmall.rawValue)
                
            }.background(Color.primaryColor)
            .onAppear() {
                viewModel.data()
            }
            
            if viewModel.loading {
                CustomProgressView()
            }
        }
    }
}

struct CountdownView_Previews: PreviewProvider {
    
    static var previews: some View {
        CountdownRouter.view(delegate: nil)
    }
    
}
