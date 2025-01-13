# FeedMe

A simple restaurant feed app that pulls nearby restaurant data from the Yelp API

## Description

The FeedMe app consists of 2 major screens, a restaurant list screen and a detail screen. Upon launch the user lands on the restaurant list screen. If this is the initial launch they are prompted to enable location access. If granted, the user's location is obtained and a request is made to load a list of restaurants. If declined, an error message is shown and the user is prompted to manually search for a location. The restaurant list screen also contains a toolbar with field to search for locations as well as a segmented control for sorting the results. Upon selecting a restaurant from the list, the user is taken to the detail screen for that restaurant which displays a large photo and various pieces of information about the business.

## Limitations

The free tier of the Yelp fusion API has some limitations that needed to be designed around. Firstly, there is some rate limiting on the free tier. While I never hit this limit in my testing, the app will handle this specific error along with various others by warning the user with an alert. Other limitations with the free tier include limited business info being returned. 

## Design Considerations

From a physical design perspective, several considerations were made to make not just for a pleasing user experience but also a functional and adaptive one. For one I used Apple native controls, materials, and adaptive colors whenever possible to make it easy to support dark mode, accesibility features and acceptable contrast ratios. On the creative side, the use of gradients and materials with luminosity allowed me to add a little interest to the design with a subtle frosted glass effect. Additionally, efforts were made to insure usablity such as accessibility tags being added to certain elements and strings being localized for multilanguage support (currently English and Spanish).

The architecture of the app follows an MVVM pattern and uses dependency injection, separating business logic from views to insure easy testability. API services are abracted through the use of protocols to enable easy mocking of network services. While modularization didn't seem necessary at this stage, the project is structured in such a way as to make for easy separation into modules in the future.  
