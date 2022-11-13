# Mini shop
After launching app,User can login by username and password then the app shows user a list of orders. 


# Demo Account
**User:**
 - Email: 106901 
 - Password: Mobile2022!Dev

# Requirement
- XCode 14.0
- macOS Monterey 12.6

# Installation
- To run the project :
- Open Alzura.xcodeproj

# Language used 
- Swift 5.0 and later

# Deployment Target 
- iOS 14.0

# App Version
- 1.0.0 

# UI
 **UIKit**
- Modern View Configuration With UIContentConfiguration.
- Xib
- Genrating UI via code.

# Design Pattern Used

## MVVM-C
Model-View-ViewModel (MVVM) is a UI architectural design pattern that decouples UI code from the business and presentation logic of an
application. As it comes from the name, MVVM divides an application into three components to help separate the code: the model, the view, and
the view model.

- Model : The Model defines core types and implements application business logic. It is completely independent of the view and view-model and reusable in many across the application.
- View : The View is a UIKit object—like a common UIViewController. It usually has a reference of the ViewModel—which is injected by the Coordinator—to create the bindings.The View defines the layout, appearance and structure of the UI. The view informs the ViewModel about user interactions and observables state changes exposed by the viewModel.
- ViewModel : The ViewModel is responsible for wrapping the model and providing state to the UI components. It also defines actions, that can be used by the view to pass events to the model. However, it shouldn’t have access to the view.
- Coordinator: Its responsibility is to show a new view and to inject the dependencies which the View and ViewModel need.The Coordinator must provide a start method to create the MVVM layers and add View in the view hierarchy.

![MVVM](https://miro.medium.com/max/1400/1*vDKyLYW7dmErE00DeBTPxg.jpeg)


# Features

## Login View
- Shows a screen with Email and Password inputs

## List View
- Shows a list of order with primary information.


# Assumptions                
-   Mobile and iPad platform supported: iOS (14.x +)        
-   Device support : iPhone , iPad 

# Unit Test
- unit test(Just Storage layer)

#### App Demo
<table>
 <tr>
  <td style = "padding: 15px;">
   <img width = "205" height = "448" src="https://user-images.githubusercontent.com/5070406/201547024-e29b7e3a-8179-4bd9-ba57-9caa3340eb09.png" alt="" />
  </td>
  <td style = "padding: 15px;">
   <img width = "205" height = "448" src="https://user-images.githubusercontent.com/5070406/201547054-cbbd1844-e481-4a72-b806-238b1f461705.png" alt="" />
  </td>
 </tr>
</table>


