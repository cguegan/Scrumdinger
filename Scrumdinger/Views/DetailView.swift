//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Christophe Guégan on 15/12/2020.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var scrum: DailyScrum
    @State private var data: DailyScrum.Data = DailyScrum.Data()
    @State private var isPresented: Bool = false
    
    var body: some View {
        List {
            // Meeting Info
            Section(header: Text("Meeting Info")) {
                NavigationLink(
                    destination: MeetingView(scrum: $scrum),
                    label: {
                        Label("Start Meeting", systemImage: "timer")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                            .accessibilityLabel(Text("Start meeting"))
                    })
                
                HStack {
                    Label("Length", systemImage: "clock")
                        .accessibilityLabel(Text("Meeting length"))
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                HStack {
                    Label("Color", systemImage: "paintpalette")
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(scrum.color)
                }
                .accessibilityElement(children: .ignore)
            }
            
            // Attendees
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees, id: \.self) { attendee in
                    Label(attendee, systemImage: "person")
                        .accessibilityLabel("Person")
                        .accessibilityValue(Text(attendee))
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing: Button("Edit") {
            isPresented = true
            data = scrum.data
        })
        .navigationTitle(scrum.title)
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                EditView(scrumData: $data)
                    .navigationTitle(scrum.title)
                    .navigationBarItems(
                        leading: Button("Cancel") { isPresented = false },
                        trailing: Button("Done") {
                            isPresented = false
                            scrum.update(from: data)
                        })
                
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum:  .constant(DailyScrum.data[0]))
        }
    }
}
