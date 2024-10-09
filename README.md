Hi Fetch Team - I am very excited to explore iOS opportunities with your team. I am creating this document to aid you while you explore my project and also explain some of my design decisions. 

# Steps to Run the App

1. Download the repo
2. Use XCode 15 and above to open the xcode project file (I used XCode 15.4 to develop the app and was able to run on iPhone 15 pro max simulator running on 17.2)
3. I also used KingFisher (https://github.com/onevcat/Kingfisher) swift package - please ensure that XCode can access this package if you are running behind a company VPN

Here is video of the app UX

https://github.com/user-attachments/assets/8ff3b9a5-561e-4f72-a25e-eba177954ab4



# Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

1. The app has the following functionalities - pull to refresh, search functionality on Recipe name and cuisine and we can also sort the recipes based on recipe name ascending / descending
2. I chose programmatic UI approach using UIKit. 
3. I focused on writing code which is scalable, testable and maintainable by adhering to SOLID principles
4. I have written unit tests testing the view model thoroughly
5. I have ensured that the code supports both iOS and iPadOS, dynamic text and different orientations
6. I have incorporated empty state ux too (please see pic in the below section)


# Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

Approximately 5 - 6 hrs

# Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I chose programmatic UI approach using UIKit instead of using storyboards - this allowed me to support different devices - iPhone and iPad using single code base and also allow the flexibility to adhere to SOLID principles like depedency injection etc.

I chose completion handlers - instead of async wait 

I did not use SwiftUI


# Weakest Part of the Project: What do you think is the weakest part of your project?

The protocol for view model FTRecipeListViewModelProtocol is large. I thought of splitting it into multiple smaller protocols to adhere to SOLID principles and also allow extensive testing

Please note ideally if time permits, I would have created a custom view that encapsulates search bar and table view and that custom view would have been powered by our FTRecipeListViewModel adhering to a puristic MVVM pattern. 

I have not incoporated support for UI automation testing

# External Code and Dependencies: Did you use any external code, libraries, or dependencies?

I also used KingFisher (https://github.com/onevcat/Kingfisher) swift package - please ensure that XCode can access this package if you are running behind a company VPN. This package handles caching of image. 

# Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

<img width="343" alt="Screenshot 2024-10-09 at 8 21 24 AM" src="https://github.com/user-attachments/assets/e30bc5d3-5cf4-4d2d-a205-a3f477076bf3">

Above picture is an expanded view of all the files in my demo project. Please note: I used prefix **FT** for all the files. **FT** stands for Fetch 

1. The files beneath the “**BaseInfra**” folder are base classes. All the functionality will extend base classes / implement protocols - **FTBaseModel**, **FTBaseViewModel** etc. This will help if the project grows and we encounter common functionality, we already have an infrastructure in place and can explore moving some functionality to base classes.   A case in point - **FTBrandedViewController** contains “Fetch App Demo” label on top as a brand and our main view controller **FTRecipeListViewController** extends **FTBrandedViewController** and gets the “Fetch Demo App” label for free.
2. The files beneath the “**Model**” folder are the model structs.
3. The files beneath the “**Views**” folder contain views related to our project. For our demo project - I have only created a custom table view cell - “FTRecipeTableViewCell”.
4. The files beneath the “**ViewModel**” folder contain view models related to our project. We only have one view model - **FTRecipeListViewModel** implements (currently empty) FTBaseViewModel protocol.  Our view model is responsible for talking to server endpoints and handling search functionality as user types and also sorting.   Communication between FTRecipeListViewModel and FTRecipeListViewController happens via FTRecipeListViewModelDelegate.
5. The files beneath the "**Error**" folder contains base Error enum used in our project “FTError”
6. I have incorporated empty state UX
<img width="472" alt="Screenshot 2024-10-08 at 4 32 58 PM" src="https://github.com/user-attachments/assets/8cad4375-ce8f-49c5-9ef2-b74b765ddf01">

7. I also ensured that the app has no memory leaks
<img width="1550" alt="Screenshot 2024-10-08 at 3 04 43 PM" src="https://github.com/user-attachments/assets/11a52509-3e63-48b7-85fd-96315a5c8e32">









