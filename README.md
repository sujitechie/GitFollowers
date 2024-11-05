# GitHub Followers

An iOS application built in Swift that fetches and displays GitHub followers based on a username search. The app provides a clean, user-friendly interface where users can search for a GitHub username to view its followers displayed in a `UICollectionView`. Selecting a follower from the list reveals detailed information about that particular follower.

## Features

- **Username Search**: Enter a GitHub username to fetch and view a list of followers in real-time.
- **Followers List**: Followers are displayed in a responsive `UICollectionView` layout, optimized for both portrait and landscape views.
- **Follower Details**: Tapping on a follower brings up detailed information, including their GitHub profile details (such as bio, location, and follower/following count).
- **Error Handling**: Displays appropriate error messages when a user or followers cannot be fetched.

## Installation

To run the project locally, follow these steps:

1. Clone the repository:
```shell
git clone https://github.com/sujitechie/GitFollowers.git
```
2. Open the project in Xcode:
```shell
cd GitFollowers
open GITFollowers.xcodeproj
```
3. Build and run the project on the iOS Simulator or a physical device.

## Requirements
- iOS: 13.0+
- Xcode: 12+
- Swift: 5
