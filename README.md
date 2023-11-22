# Brana Audiobooks App Documentation

Welcome to the documentation for the Brana Audiobooks app. This document provides a user perspective to offer a comprehensive understanding of the application.

## User Documentation

## 1. Splash Screen

The Brana Audiobooks splash screen serves as the initial screen upon launching the app. Its purpose is to create a smooth and engaging transition for users while essential background tasks are executed.

![Image Alt text](spl.png)

### Interface Element:
The splash screen features the Brana Audiobooks logo at the center, creating a visually appealing introduction to the app.

### User Journey:
Onboarding Check:
The app checks if the user has completed the onboarding process.
If completed, the user is directed to the login page.
If not completed, the user is navigated to the onboarding screens.

```
Future<void> _checkOnboardingStatus() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasCompletedOnboarding = prefs.getBool('hasCompletedOnboarding') ?? false;
    bool isLoggedOut = prefs.getBool('isLoggedOut') ?? true;
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedOut) {
      // User is logged out, navigate to login page
      _navigateToLogin();
    } else if (isLoggedIn) {
      // User is logged in, navigate to homepage
      _navigateToHomePage();
    } else if (hasCompletedOnboarding) {
      // Onboarding has been completed, navigate to LoginPage
      _navigateToLoginPage();
    } else {
      // Onboarding has not been completed, navigate to Onboarding
      _navigateToOnboarding();
    }
  } catch (e) {
    // Handle exceptions if any
    print('Error checking onboarding status: $e');
  }
}
```
### Login Status Check:
The app verifies if the user is currently logged in.
If logged in, the user is directed to the home page.
If not logged in, the user is navigated to the login page.

### Navigation Timing:
The splash screen displays for a brief moment (2 seconds) to provide a smooth transition.
After the specified time, users are automatically redirected based on the app's logic.



## 2. Signup page
The Sign-Up Page is where users can create a new account to access the features and content of the Brana Audiobooks app. This page collects necessary information from users to create their accounts securely.

![Image Alt text](si.png)

### Interface Element:
User-friendly Interface:
The page presents a clean and intuitive design, making it easy for users to navigate and fill in their details.

### User journey 
### Form Validation:
The form includes validation checks for each input field to ensure that users provide accurate and appropriate information.

### Secure Sign-Up Process:
The sign-up process communicates with the Brana Audiobooks server securely to register users.

### Error Handling:
In case of any errors during the sign-up process, users will receive informative error messages to guide them on resolving issues.

### Success Notification:
Upon successful sign-up, users receive a confirmation dialog indicating that the registration process was successful.

### Navigation:
Users can navigate between different input fields smoothly, and the page includes a back button for easy navigation.

## 3. Login Page
The Login Page is where users can access their Brana Audiobooks accounts by entering their email and password. This page is designed to provide a secure and straightforward login experience.
![Image Alt text](log.png)
### Interface Element
### User-friendly Interface:
The page presents a clean and intuitive design, making it easy for users to navigate and enter their login credentials.

### User journey 
Form Validation:
The login form includes validation checks to ensure that users provide the necessary information and receive appropriate feedback.

### Password Visibility Toggle:
Users can toggle the visibility of the password field, providing the option to view or hide their entered password.

### Navigation Options:
Users can navigate to the Signup Page or the Forgot Password Page directly from the Login Page.

### Login Button:
The "LOGIN" button initiates the login process securely, verifying user credentials with the Brana Audiobooks server.

## 4. Home Screen:
Upon launching the app, users are presented with a Home Screen featuring recommended audiobooks, curated picks, and dedicated content for children.
![Image Alt text](home.png)
### Interface Elements 
### Authors Section:
Authors: Explore a diverse collection of authors by tapping on the "Authors" section. The "Show all" option allows users to access a comprehensive list of authors.

### Editor's Picks:
Editor's Picks: Discover noteworthy audio books curated by editors. The "Show all" option provides access to the full list of editor-recommended audiobooks.


### Podcasts Section:
Podcasts: Immerse yourself in the world of podcasts by navigating to the dedicated "Podcasts" section. The "Show all" option enables users to explore the complete podcast library.
### Children's Section:
Children: Tailored content for young listeners is available in the "Children" section. Users can view all children's content by selecting the "Show all" option.
### Connectivity Check:
The app checks for internet connectivity at launch. If there's no internet connection, a preloader indicates that certain features may be limited until a connection is established.


## 5. Explore page 
The Explore Page is a central hub for discovering new audiobooks and genres. It provides a visually appealing and user-friendly interface for users to explore various genres, access curated lists, and discover audiobooks based on their preferences.
![Image Alt text](expl.png)

### Interface Elements
Genre Exploration:
The page displays a list of audiobook genres with associated information such as genre name, audiobook count, and a thumbnail image.

### Interactive Genre Widgets:
Each genre is presented as an interactive widget, allowing users to tap on a genre to view more details and explore specific audiobooks within that genre.

### Categories Scroller:
A horizontal scroller at the top of the page showcases different categories such as Liked, Latest, and Wishlist, providing quick access to specific audiobook collections.

### Responsive Design:
The page is designed to be responsive, adapting to different screen sizes for an optimal user experience.
![Image Alt text](ns.png)
![Image Alt text](jsb.png)

## 6. Profile page 
The Profile Page serves as a personalized space for users to manage their account information, view statistics, and customize their profile. This documentation will walk you through the key features and functionalities of the Profile Page.
![Image Alt text](Screenshot%(740)-07.png)
