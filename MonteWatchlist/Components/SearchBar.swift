import SwiftUI

// Search bar component
struct SearchBar: View {
    @Binding var text: String
    var onSubmit: (() -> Void)?

    var body: some View {
        HStack {
            TextField("Search movies...", text: $text)
                .padding(8)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .onSubmit {
                    onSubmit?()
                }
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                            .padding(.leading, 8)

                        if !text.isEmpty {
                            Button(
                                action: {
                                    text = ""
                                },
                                label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            ).buttonStyle(PlainButtonStyle())
                        }
                    }
                )
        }
        .enableInjection()
    }

    #if DEBUG
        @ObserveInjection var forceRedraw
    #endif
}
