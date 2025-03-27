# Renting-App-using-clean-architecture-with-getX
A modern Renting App built using Flutter that follows the Clean Architecture principles, utilizing the GetX state management and dependency injection framework. This app serves as a scalable and maintainable solution for managing rental properties, allowing users to explore, rent, and manage their listings.
Features
Property Listings: Browse rental properties with detailed descriptions, photos, and pricing information.
Search and Filters: Advanced search functionality with filters for location, price range, and property type.
User Authentication: Secure login and registration with email and password.

#Favourites: 

Save favourite properties for quick access later.
Booking Management: Schedule viewings and manage rental agreements.
Notifications: Receive updates on bookings, payment reminders, and property availability.
Technologies Used
Flutter: For building a cross-platform mobile application with a consistent UI/UX.
Clean Architecture: Ensures a separation of concerns, making the app more modular, testable, and maintainable.
GetX: For state management, dependency injection, and routing, providing a reactive and efficient solution.
Project Structure
The project follows the Clean Architecture structure, divided into the following layers:

#Presentation Layer:

UI: Flutter widgets that define the visual structure of the app.
Controllers: GetX controllers that manage the state and handle user interactions.
Domain Layer:

Entities: Core business models representing the app's essential data structures.
Use Cases: Business logic for handling different user scenarios, such as fetching properties or booking rentals.
Data Layer:

Repositories: Interfaces and implementations for data access, abstracting the source (API, local database).
Data Sources: Handles communication with external sources (e.g., REST API, Firebase).
Models: Data models that convert API responses to domain entities.
