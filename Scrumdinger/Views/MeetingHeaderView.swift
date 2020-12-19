//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Christophe Guégan on 18/12/2020.
//

import SwiftUI

struct MeetingHeaderView: View {
    
    @Binding var secondElapsed: Int
    @Binding var secondRemaining: Int
    
    private var progress: Double {
        guard secondRemaining > 0 else { return 1 }
        let totalSeconds = Double(secondElapsed + secondRemaining)
        return Double(secondElapsed) / totalSeconds
    }
    
    private var minutesRemaining: Int {
        secondRemaining / 60
    }
    
    private var minutesRemainingMetric: String {
        minutesRemaining == 1 ? "minute" : "minutes"
    }
    
    let scrumColor: Color
    
    var body: some View {
        
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(scrumColor: scrumColor))
            HStack {
                VStack {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondElapsed)", systemImage: "hourglass.bottomhalf.fill")
                    
                }
                Spacer()
                VStack {
                    Text("Seconds Remaining")
                        .font(.caption)
                    HStack {
                        Text("\(secondRemaining)")
                        Image(systemName: "hourglass.tophalf.fill")
                    }
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("Time remaining"))
        .accessibilityValue(Text("\(minutesRemaining) \(minutesRemainingMetric)"))
        .padding([.top, .horizontal])
    }
}

// MARK: - Preview
struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(secondElapsed: .constant(60),
                          secondRemaining: .constant(180),
                          scrumColor: DailyScrum.data[0].color)
            .previewLayout(.sizeThatFits)
    }
}
