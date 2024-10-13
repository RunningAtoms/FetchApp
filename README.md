Hi Fetch Team - I am very excited to explore iOS opportunities with your team. I am creating this document to aid you while you explore my project and also explain some of my design decisions. 

# Steps to Run the App

1. Download the repo
2. Use XCode 15 and above to open the xcode project file (I used XCode 15.4 to develop the app and was able to run on iPhone 15 pro max simulator running on 17.2)
3. I also used KingFisher (https://github.com/onevcat/Kingfisher) swift package - please ensure that XCode can access this package if you are running behind a company VPN
4. There is a class called **FTAppFactory** and it has a property **useSwiftUI** if it is set to true, app will show SwiftUI powered user experience and if it is set to false, it will show UIKit powered user experience.

Here is video of the app UX

**SwiftUI powered user experience** 

https://github.com/user-attachments/assets/b17dcafa-0f10-4662-a76f-e337d7910dae

----------------------------------------------------------------------------------

**UIKit powered user experience**

https://github.com/user-attachments/assets/8ff3b9a5-561e-4f72-a25e-eba177954ab4



# Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

1. The app has the following functionalities - pull to refresh, search functionality on Recipe name and cuisine and we can also sort the recipes based on recipe name ascending / descending and images are cached
2. I chose programmatic UI approach instead of Storyboard in UIKit and also implemented SwiftUI experience
4. I focused on writing code which is scalable, testable and maintainable by adhering to SOLID principles
5. I have written unit tests testing the view model- both UIKit and SwiftUI  thoroughly
6. I have ensured that the code supports both iOS and iPadOS, dynamic text and different orientations
7. I have incorporated empty state ux too - in UIKIt and SwiftUI user experience (please see pic in the below section)

# Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

Approximately 5 - 6 hrs

# Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I chose programmatic UI approach using UIKit instead of using storyboards - this allowed me to support different devices - iPhone and iPad using single code base and also allow the flexibility to adhere to SOLID principles like depedency injection etc.

I also to used SwiftUI views in UIKit to simulate code base in transition

The service layer has both completion handler and async wait versions to simulate code base in transition


# Weakest Part of the Project: What do you think is the weakest part of your project?

I wanted to have one view model to power both UIKit and SwiftUI experience instead of separate view models.

The protocol for view model that powers UIKit experience - **FTRecipeListViewModelProtocol** is large. I thought of splitting it into multiple smaller protocols to adhere to SOLID principles and also allow extensive testing.

Please note ideally if time permits, in UIKit experience - I would have created a custom view that encapsulates search bar and table view and that custom view would have been powered by our FTRecipeListViewModel adhering to a puristic MVVM pattern. 

I have not incoporated support for UI automation testing

# External Code and Dependencies: Did you use any external code, libraries, or dependencies?

I used KingFisher (https://github.com/onevcat/Kingfisher) swift package - please ensure that XCode can access this package if you are running behind a company VPN. This package handles image caching - ensures that we don't download same images again and again. 

# Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

<img width="347" alt="Screenshot 2024-10-13 at 12 23 17 PM" src="https://github.com/user-attachments/assets/1b733530-23d6-4299-981b-4a6f5a1052ce">

Above picture is an expanded view of all the files in my demo project. Please note: I used prefix **FT** for all the files. **FT** stands for Fetch 

1. The files beneath the “**BaseInfra**” folder are base classes. All the functionality will extend base classes / implement protocols - **FTBaseModel**, **FTBaseViewModel** etc. This will help if the project grows and we encounter common functionality, we already have an infrastructure in place and can explore moving some functionality to base classes.   A case in point - **FTBrandedViewController** contains “Fetch App Demo” label on top as a brand and our main view controller **FTRecipeListViewController** extends **FTBrandedViewController** and gets the “Fetch Demo App” label for free.
2. The files beneath the “**Model**” folder are the model structs - **FTRecipeList**, **FTRecipe**
3. The files beneath the “**Views**” folder contain views related to our project. For our demo project - I have created a custom table view cell - “FTRecipeTableViewCell” for UIKit experience. **FTRecipeRowSwiftUIView**, **FTRecipeListSwiftUIView** are SwiftUI views
4. The files beneath the “**ViewModel**” folder contain view models related to our project. We only have two view model - **FTRecipeListViewModel** powers UIKit user experience implements (currently empty) FTBaseViewModel protocol.  Our view model is responsible for talking to server endpoints and handling search functionality as user types and also sorting.   Communication between FTRecipeListViewModel and FTRecipeListViewController happens via FTRecipeListViewModelDelegate.  **FTRecipeListSwiftUIViewModel** powers SwiftUI experience. 
5. The files beneath the "**Error**" folder contains base Error enum used in our project “**FTError**”
6. I have incorporated empty state UX

**UIKit no records ux**   

<img width="472" alt="Screenshot 2024-10-08 at 4 32 58 PM" src="https://github.com/user-attachments/assets/8cad4375-ce8f-49c5-9ef2-b74b765ddf01">


--------------------------------------------------------
**SwiftUI no records ux**

<img width="472" alt="Screenshot 2024-10-08 at 4 32 58 PM" src="https://github.com/user-attachments/assets/53b7d648-238c-4296-b612-d4b8d0896ca3">


8. I also ensured that the app has no memory leaks









