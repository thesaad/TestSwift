## Project Title  

Yassir Home Take Away Assignment

## Description

A pagination of Characters API with loadmore and pull to refresh functionality. 
## Structure

The Code mainly has MVVM. It consists of mixture of UIKit and SwiftUI. Initial List is done in UIKit by subclassing UIViewController and using UITableview, A TableviewCell is used for reuse purpose which further uses a SwiftUI View internally to display data in list. The detail screen upon selection is written in SwiftUI. 

For API Calls, async Await can be used but to have symmtry, Combine is used both for UIKit and SwiftUI. The Detail screen uses StateObject rather than ObservableObject wrapper so that it's not destroyed always. An extension is created to make use of Combine Publishers without saving subscriptions at class level

For modular approach, The project is divided into just two modules so that an idea is expressed for modules.

APIs layer is developed using Protocol Oriented approach, every module has its protocol. Then an extension of main 
APIGateway is used to implement that module's protocol. For API, shared Singelton instance is not created so that every module has its own copy of API Instance to have better performance. 


## Dependencies

Project uses two Swift Packages, using SPM, one for Loading Indicator and Internet Reachability. 

### Prerequisites

XCode 15.3 was used to create this project, Some of versions mismatch can be possible if used in a different version of Xcode. 

### Installing

- Open XCode Project file in Xcode,
- Wait for Swift package manager to load package dependencies
- Run project. 


## Assets
Fonts and Images are just some examples found on internet and to express how can we use them. 

## Running the tests

As this was a small project so Tests are not much covered. A small number of Test Cases are stated as reference only.  

### CI/CD

CI/CD Was not scope but XCode cloud can be setup if required. 

## Git

Git ignore file contains a common list of ingored files and folders required not to be pushed on github

## Authors

* **Saad ** - *Initial work* - 

## License

This project is for test purposes and copy of this code or usage is subject to Yassir's approval

