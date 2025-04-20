//
//  SignupProgressBarView.swift
//  Pinnected
//
//  Created by Jackson Patrick on 20/04/25.
//

import SwiftUI

struct SignupProgressBarView: View {
    var progressWidth: CGFloat = 0
    var totalProgressWidth: CGFloat = 0
    @State private var containerWidth: CGFloat = 0  // Store container width to avoid recalculation during layout changes
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 16) {
            Text("\(Int(progressWidth)) of \(Int(totalProgressWidth))")
            
            GeometryReader { geo in
                Color.clear  // Invisible view to capture geometry
                    .onAppear {
                        self.containerWidth = geo.size.width
                    }
                    .onChange(of: geo.size.width) { newWidth in
                        self.containerWidth = newWidth
                    }
            }
            .frame(height: 0)  // GeometryReader's only purpose here is to measure width
            
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray)
                    .frame(height: 10)
                
                Capsule()
                    .fill(Color.colorPrimaryFont)
                    .frame(width: self.progressCalculator(value: progressWidth, maxValue: totalProgressWidth, width: containerWidth))
                    .animation(.easeInOut, value: progressWidth)  // Animation will happen only when progressWidth changes
            }
            .frame(height: 10)
        }
        .padding(.horizontal)  // Add padding if needed
    }
    
    // MARK: Progress Calculator
    private func progressCalculator(value: CGFloat, maxValue: CGFloat, width: CGFloat) -> CGFloat {
        guard maxValue > 0 else { return 0 }
        let percentage = value / maxValue
        return width * percentage
    }
}

#Preview {
    SignupProgressBarView()
}
