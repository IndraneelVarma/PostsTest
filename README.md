## Project Setup

1. Requirements:
   - Xcode 16 or newer
   - iOS 17 deployment target 

2. Setup steps:
   - Clone the repository
   - Open `BattleBucks.xcodeproj`
   - Select an iOS Simulator 
   - Build & Run


## iOS & Xcode Version Used

- iOS: 17+
- Xcode: 26

You can update the deployment target and Xcode version as needed, but newer SwiftUI APIs may require iOS 17+.

## Architecture: MVVM + Clean

This project follows a lightweight MVVM structure with a hint of Clean principles:

- Model
  - `PostModel`: a swift codable model that represents a Post entity
- ViewModel
  - `PostViewModel`: responsible for all the state changes in the UI related to loading, fetching posts etc..
- Repository / Data Layer
  - `PostRepository`: Singular source of truth, API call happens in this layer. 
- View
  - `PostsView`: Displays categories (All / Favourites), searchable list of posts, pull-to-refresh, and navigation to a full post detail.
  - `PostCardView`: Renders an individual post card and supports favoriting via a `Binding<Set<Int>>`.
  - `FullPostView`: Displays the full content for a selected post and interacts with favorites.

## Improvements with More Time

- Persistence:
  - Store posts and favourites using `Realm`, `SqlLite`, or `Core Data`.
- Error Handling & UX:
  - More descriptive error states and retry buttons.
  - Empty-state views for no results / no favorites.
  - Better looking UI/UX overall, main focus here was on functionality
- Networking:
  - Add request cancellation, better decoding error handling, and caching.
