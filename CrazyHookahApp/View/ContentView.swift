import SwiftUI

struct ContentView: View {
    @StateObject private var manager = StateManager()
    @StateObject private var store = CrazyHookahStore()
        
    var body: some View {
        Group {
            switch manager.appState {
            case .request:
                Loading()
                
            case .support:
                if let url = manager.networkManager.crazyHookahURL {
                    WKWebViewManager(
                        url: url,
                        webManager: manager.networkManager
                    )
                } else {
                    WKWebViewManager(
                        url: NetworkManager.initialURL,
                        webManager: manager.networkManager
                    )
                }
                
            case .loading:
                CrazyHookahRootView()
                    .environmentObject(store)
                    .preferredColorScheme(.dark)
            }
        }
        .onAppear {
            manager.stateRequest()
        }
    }
}

#Preview {
    ContentView()
}
