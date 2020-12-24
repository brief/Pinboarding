import Combine
import Foundation

protocol BookmarkViewModelProtocol {
    var title: String { get }
    var description: String { get }
    var tags: String { get }
}

final class BookmarkViewModel: BookmarkViewModelProtocol {

    // MARK: - Properties

    let title: String
    let description: String
    let tags: String

    // MARK: - Life cycle

    init(
        bookmark: Post
    ) {
        self.title = bookmark.title
        self.description = bookmark.abstract
        self.tags = bookmark.tags
            .compactMap { $0 as? Tag }
            .map { $0.name }
            .joined(separator: ", ")
    }
}
