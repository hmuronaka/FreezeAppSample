//
//  ContentView.swift
//  FreezeAppSample
//
//  Created by MuronakaHiroaki on 2023/11/18.
//

import SwiftUI
import AVFoundation

@MainActor
class ContentModel: ObservableObject {
    private let player: AVPlayer
    @Published var title: String?
    @Published var idx: Int?
    
    init() {
        player = AVPlayer(playerItem: nil)
    }
    
    func load(idx: Int) {
        let url = Bundle.main.url(forResource: "oneminute", withExtension: "m4a")! // Change to your audio file.
        let avassetURL = AVURLAsset(url: url, options: [AVURLAssetPreferPreciseDurationAndTimingKey: true])
        let avPlayerItem = AVPlayerItem(asset: avassetURL)
        self.player.replaceCurrentItem(with: avPlayerItem)
        self.idx = idx // If you comment out this line, it might not occur.
    }
}

@available(iOS 17, *)
struct ContentView: View {
    @EnvironmentObject private var model: ContentModel
    
    private let urls: [URL] = {
        (0..<50).map { URL(fileURLWithPath: "\($0)")}
    }()
    
    @State private var selected: Int?
    
    var body: some View {
        List(selection: $selected) {
            ForEach(urls.indices, id: \.self) { idx in
                let _ = urls[idx]
                NavigationLink(value: idx) {
                    Text("\(idx)")
                }
            }
        }
        .onChange(of: selected, { oldValue, newValue in
            if let newValue {
                model.title = "\(newValue)"
            } else {
                model.title = nil
            }
        })
        .navigationDestination(item: $selected) { idx in
            Content3View(idx: idx)
                .environmentObject(model)
        }
    }
}

struct Content3View: View {
    
    let idx: Int
    
    @EnvironmentObject private var model: ContentModel
    
    let urls: [URL] = {
        (0..<1000).map { URL(fileURLWithPath: "\($0)")}
    }()
     
    var body: some View {
        VStack {
            ScrollViewReader { p in
                List {
                    ForEach(urls.indices, id: \.self) { idx in
                        Cell(idx: idx, u: urls[idx])
                            .environmentObject(self.model)
                            .id(idx)
                    }
                }
                .listStyle(.plain)
                .onAppear() {
                    // If you comment out this block, it might not occur
                    withAnimation {
                        p.scrollTo(500, anchor: .center)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(model.title ?? "")
        .onAppear() {
            print("will load")
            model.load(idx: idx) // It does not occur if you comment out this line
            print("did load")
        }
    }
}

struct Cell: View {
    
    @EnvironmentObject private var model: ContentModel
    
    let idx: Int
    let u: URL
    
    var body: some View {
        HStack {
            Text("\(u)")
        }
        // If you comment out this line, it might not occur
        .listRowBackground(idx == model.idx ? Color.accentColor : Color.white)
    }
}
