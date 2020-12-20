import Foundation
import Combine
import PinboardKit

final class BookmarksViewModel: ObservableObject {

    // MARK: - Properties

    @Published var bookmarks: [Bookmark] = []

    private let repository: PinboardRepository
    private let store: SettingsStore
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    init(
        store: SettingsStore = .shared
    ) {
        self.store = store

        self.repository = PinboardRepository(
            pinboardAPI: PinboardAPI { store.authToken }
        )

        self.repository
            .recentBookmarks()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { self.bookmarks = $0 }
            )
            .store(in: &cancellables)
    }
}
