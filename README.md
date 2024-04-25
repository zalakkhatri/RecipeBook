# RecipeBook

Features
* User can search for any recipe by entering a name of a recipe in the search textfield
* User can bookmark a recipe from a search result so that it can be retrieved at a later time.
* User can also delete a bookmarked recipe from the search.
* User can save his own recipe and upload a picture of the recipe. 
* User can delete saved receipe

The recipe book app is easy and convinient way to search for a recipe. There is launch screen at the beginning of the App followed by onboarding screens that show the main features of the App. After going through onbloadng screens, user lands on a Home tab. There are three different tabs in the App. Home, Saved and My Recipes. On Home tab, there is a "Search Recipe" button. On clicking the button, user needs to enter search text that is a recipe name. On clicking search, screen shows list of recipes retrieved from an API response. On clicking any recipe, user can see details of a recipe. If no result found then user will be informed about that via alert popup. There is a bookmark button next to each recipe to bookmark the recipe and retrive at a later time. The bookmarked recipes are available to view on second tab "Saved". User can click same bookmark button to remove bookmark for a specific recipe. The receipe will no longer be shown on the "Saved" tab once the bookmark is removed. On home and Saved tabs, usrer can click any recipe and see its detail on recipe detail screen. The third tab is "My Recipes". On this screen, there is an Add button to add a new recipe. On "Add Recipe" screen, user needs to enter all required fields like recipe title, ingrediants and instrutcions for the recipe in order to save a recipe details. User can upload a picture of a recipe to save with recipe details. Image is an optional. After entering all required details, "Add" button will become enable for user to save that recipe. Once the recipe is added, user can see that on "My Recipe" tab. On clicking any recipe, detail screen is accessible. User can detele any saved recipe from detail screen by clikcking "delete" button.The bookmarked and saved receipes are stored in user defaults.API key is stored in plist file.

Required App Functionality
* Xcode version 15.2 is used to develop this App. Minumum iOS version 17 is required to run this App.
* No third party frameworks are used to develop this App.
* There is a launch screen and onboading screens in the App.
* All the features of the App are completed.
* There are three screens that use a list. These screens are Home, Saved and My Recipe tab screens.
* List item contains recipe image, recipe name and/or bookmark button.
* Tapping on a recipe row on Home, Saved and My Recipe tab screens open recipe details screen.
* On all the tabs, user needs to scroll to view all the recipes.
* The App is making one GET call to "Food recipes with images" API to get recipes based in search text.The link for this API is - https://rapidapi.com/zilinskivan/api/food-recipes-with-images
* The API_Key is stored in secureKeys.plist file. Add secureKeys.plist in RecipeBook folder of the App.
* There is a limit for a usage of API key. Daily only 10 API calls are allowed.If more than 10 calls are required then we can use json to load the data for testing purpose. Uncomment line #61 from SearchRecipesView.
* In csse of any error during API call, user is informed about it. An alert is presented to the user with the error message "Error occured while fetching results".
* The App uses plist to save API key. It also user defautls to save bookmarked recipes and user's own recipes.
* The App uses SWift Modern Concurrency, asyc/await to make API call asynchroniously. App also uses MainActor to populate value of recipes Published property in SearchRecipeViewModel on the main thread.
* On SearchRecipesView, app shows text "Search for recipes for example "Pizza"". App also informs user if no recipes found for a search text. It displays alert with the message - "Result is none.".On Add recipe view, user needs to enter all required information. Without the required information, "Add" button remains disabled.
* App works on both landscape and portrait orientations.
* App also works for both light and dark modes.
* The code is organized and readable. All ViewModel files are stored in ViewModel folder. All SWiftUI View files are stored in View folder.Other App info for example Assets are stored in App folder.
* The project is implemented in MVVM architecture. SearchRecipeViewModel and MyRecipesViewModel are ObservableObject and both has multiple Published properties.
* The project utilizes SwiftLint. All lint errors are resolved.
* The project has test plan including both UI and unit test. The code coverage is 71%. All tests are executing successfully.
* The App includes a custom App icon.
* The App inlcudes an onboarding screens.
* The App includes a custom display name - "RecipeBook".
* The App includes one SwiftUI annimation on RecipeImageDetailView.
* The App includes styled text properties.

  

