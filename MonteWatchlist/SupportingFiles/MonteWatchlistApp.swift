//
//  MonteWatchlistApp.swift
//  MonteWatchlist
//
//  Created by Ali Ahmad Fahrezy on 07/05/25.
//

import SwiftData
import SwiftUI

@main
struct MonteWatchlistApp: App {

    // MARK: - Core Data Stack
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Movie.self
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    // MARK: - App Lifecycle
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}

// Injection
#if canImport(HotSwiftUI)
    @_exported import HotSwiftUI
#elseif canImport(Inject)
    @_exported import Inject
#else
    // This code can be found in the Swift package:
    // https://github.com/johnno1962/HotSwiftUI or
    // https://github.com/krzysztofzablocki/Inject

    #if DEBUG
        import Combine

        public class InjectionObserver: ObservableObject {
            public static let shared = InjectionObserver()
            @Published var injectionNumber = 0
            var cancellable: AnyCancellable? = nil
            let publisher = PassthroughSubject<Void, Never>()
            init() {
                cancellable = NotificationCenter.default.publisher(
                    for:
                        Notification.Name("INJECTION_BUNDLE_NOTIFICATION")
                )
                .sink { [weak self] change in
                    self?.injectionNumber += 1
                    self?.publisher.send()
                }
            }
        }

        extension SwiftUI.View {
            public func eraseToAnyView() -> some SwiftUI.View {
                return AnyView(self)
            }
            public func enableInjection() -> some SwiftUI.View {
                return eraseToAnyView()
            }
            public func onInjection(bumpState: @escaping () -> Void)
                -> some SwiftUI.View
            {
                return
                    self
                    .onReceive(
                        InjectionObserver.shared.publisher,
                        perform: bumpState
                    )
                    .eraseToAnyView()
            }
        }

        @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
        @propertyWrapper
        public struct ObserveInjection: DynamicProperty {
            @ObservedObject private var iO = InjectionObserver.shared
            public init() {}
            public private(set) var wrappedValue: Int {
                get { 0 }
                set {}
            }
        }
    #else
        extension SwiftUI.View {
            @inline(__always)
            public func eraseToAnyView() -> some SwiftUI.View { return self }
            @inline(__always)
            public func enableInjection() -> some SwiftUI.View { return self }
            @inline(__always)
            public func onInjection(bumpState: @escaping () -> Void)
                -> some SwiftUI.View
            {
                return self
            }
        }

        @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
        @propertyWrapper
        public struct ObserveInjection {
            public init() {}
            public private(set) var wrappedValue: Int {
                get { 0 }
                set {}
            }
        }
    #endif
#endif
