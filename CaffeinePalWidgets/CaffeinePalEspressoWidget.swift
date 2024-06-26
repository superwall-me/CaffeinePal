//
//  CaffeinePalEspressoWidget.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 6/25/24.
//

import Foundation
import AppIntents
import WidgetKit
import SwiftUI

struct EspressoTimelineProvider: TimelineProvider {
    let store: CaffeineStore = .shared
    
    func placeholder(in context: Context) -> CaffeineIntakeEntry {
        CaffeineIntakeEntry(date: .now, amount: store.todaysCaffeine)
    }

    func getSnapshot(in context: Context, completion: @escaping (CaffeineIntakeEntry) -> ()) {
        completion(CaffeineIntakeEntry(date: .now, amount: store.todaysCaffeine))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [CaffeineIntakeEntry(date: .now, amount: store.todaysCaffeine)], policy: .atEnd)
        completion(timeline)
    }
}

struct CaffeineIntakeEntry: TimelineEntry {
    let date: Date
    let amount: Double
}

struct LogEspressoWidgetView : View {
    let store: CaffeineStore = .shared
    var entry: EspressoTimelineProvider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            Text("Today's Caffeine:")
                .font(.caption)
                .padding(.bottom, 4)
            Text(store.formattedAmount(.init(value: entry.amount, unit: .milligrams)))
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color.secondary)
            Spacer()
            Button(intent: LogEspressoIntent(shots: .single)) {
                Text("Log a Shot")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
        }
    }
}

struct EspressoWidget: Widget {
    let kind: String = "com.superwall.caffeinePal.Caffeine-Pal.CaffeinePalEspressoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, 
                            provider: EspressoTimelineProvider()) { entry in
            LogEspressoWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("Espresso")
        .description("Log a shot or two of espresso.")
    }
}

#Preview(as: .systemSmall) {
    EspressoWidget()
} timeline: {
    CaffeineIntakeEntry(date: .now, amount: 200)
}
