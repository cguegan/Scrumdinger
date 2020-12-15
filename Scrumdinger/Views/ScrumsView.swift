//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Christophe Guégan on 15/12/2020.
//

import SwiftUI

struct ScrumsView: View {
    
    @Binding var scrums: [DailyScrum]
    
    var body: some View {
        List {
            ForEach(scrums) { scrum in
                NavigationLink(
                    destination: DetailView(scrum: binding(for: scrum)),
                    label: {
                        CardView(scrum: scrum)
                    })
                    .listRowBackground(scrum.color)
            }
        }
        .navigationTitle("Daily Scrums")
    }
    
    private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
        guard let scrumIndex = scrums.firstIndex(where: { $0.id == scrum.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $scrums[scrumIndex]
    }
    
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.data))
        }
    }
}
