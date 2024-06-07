# task_assignment

A new Flutter project.

## Hope you will enjoy 

## Clean Architecture with Repository Design Pattern:

    Clean Architecture divides the project into layers: Presentation, Domain, and Data. Each layer has distinct responsibilities, ensuring separation of concerns.
    Repository Pattern provides a centralized place to handle data operations, abstracting the underlying data source (whether it be a network, database, or local storage).

## Native Splash Screen:

    Implemented by configuring platform-specific native files (e.g., Android's launch_background.xml and iOS's LaunchScreen.storyboard), this ensures the splash screen appears immediately as the app launches.

## Custom Paint and Custom Navigation Bar:

    Custom Paint allows for drawing complex graphics and shapes, which are used to create a unique and engaging bottom navigation bar. This is achieved by extending the CustomPainter class.

## Isolates for Loading Product Items:

    Dart's isolates enable concurrent execution. By loading product data in an isolate, the app remains responsive while handling potentially heavy data processing tasks in the background.

## Price Low to High Filter Option:

    Implemented by sorting the product list based on the price attribute in ascending order. This feature enhances usability by providing users with a way to easily find more affordable products.

## GetX State Management:

    GetX offers a reactive and easy-to-use state management solution. It simplifies the process of updating the UI in response to state changes, and its built-in dependency injection makes it easier to manage dependencies.

## Dio for Network Calls:

    Dio is configured for making REST API calls. It supports features like request cancellation, timeout, custom adapters, and interceptors for handling responses and errors.

## Central Error Handling:

    Centralized error handling captures exceptions globally. When an error occurs, an automatic dialog is displayed to inform the user. This is typically implemented by wrapping the main widget in an ErrorWidget handler or using GetX's error handling capabilities.

## Reusable Widgets:

    The project includes a library of reusable widgets, which can be easily incorporated into different parts of the application. Examples include custom buttons, form fields, and modal dialogs. These widgets are designed to be flexible and customizable, promoting code reuse and consistency.



## Project Stracture

|-- lib
    |-- main.dart
    |-- app
        |-- core
            |-- usecases
        |-- config
            |-- app_constants.dart
            |-- app_colors.dart
            |-- app_space.dart
        |   |-- app_text_styles.dart
        |   |-- app_text.dart
        |   |-- asset_strings.dart
        |-- services
        |-- util
        |-- types
        |-- extensitons
    |-- data
        |-- helper
        |-- models
        |-- repositories
        |-- providers
            |-- database
            |-- remote
                |-- core
                |-- datasource
                |-- network
                
    |-- domain
        |-- entities
        |-- repositories
        |-- usecases
    |-- presentation
        |-- controllers
        |-- pages
        |-- views
        |-- app.dart