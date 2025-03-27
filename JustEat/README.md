# Fork & Find - Just Eat Assessment

A SwiftUI-based iOS application that displays restaurant information from the Just Eat API in a Tinder-style card interface.

## Features

- Tinder-style card swipe interface for restaurant browsing
- Display of restaurant name, cuisines, rating, and address
- Interactive swipe gestures (left for dislike, right for like)
- Automatic storage of highly rated restaurants (4.0+ stars)
- Clean, modern UI with smooth animations
- Support for UK postcodes

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## Building and Running

1. Clone the repository
2. Open `JustEat.xcodeproj` in Xcode
3. Select your target device or simulator
4. Click the Run button (⌘R) or select Product > Run from the menu

## Project Structure

- `Models/Restaurant.swift`: Data model for restaurant information
- `Networking/NetworkManager.swift`: API communication handling
- `Views/RestaurantCardView.swift`: Card UI component
- `Views/ContentView.swift`: Main application view

## Assumptions and Notes

1. The API only works with UK postcodes
2. We're limiting the display to the first 10 restaurants from the API response
3. The rating is displayed as a number with one decimal place
4. Restaurants with a rating of 4.0 or higher are automatically saved as "liked"
5. The app requires an active internet connection to function

## Potential Improvements

1. Add persistence for liked restaurants using CoreData or UserDefaults
2. Implement a detailed view for each restaurant
3. Add filtering options for cuisines and ratings
4. Include restaurant images in the cards
5. Add a map view to show restaurant locations
6. Implement offline caching of restaurant data
7. Add unit tests and UI tests
8. Include error handling for invalid postcodes
9. Add loading animations and transitions
10. Implement a favorites list view

## API Information

The application uses the Just Eat API endpoint:
```
https://uk.api.just-eat.io/discovery/uk/restaurants/enriched/bypostcode/{postcode}
```

Replace {postcode} with a valid UK postcode (e.g., EC4M7RF). 