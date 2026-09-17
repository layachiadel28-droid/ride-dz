# Ride DZ

A Flutter starter app for a ride-sharing service inspired by inDrive.

## Features
- Rider flow
- Driver flow
- Admin dashboard
- Distance-based pricing (10 DZD per km)
- Ride request screen
- Driver dashboard
- Map screen

## Tech stack
- Flutter
- Google Maps
- Geolocator

## Getting started

1. Install Flutter SDK.
2. Run:
   ```bash
   flutter pub get
   flutter run
   ```
3. Add your Google Maps API key to Android/iOS configuration before using the map screen.

## Structure
- `lib/screens` — main screens
- `lib/models` — data models
- `lib/services` — pricing and matching logic

## Notes
This is a starter MVP. Firebase and production backend integration can be added next.
