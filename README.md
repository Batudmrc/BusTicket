# BusTicket

An iOS app that simulates a ticket reservation system. Made with UIKit

## Functions

* Onboarding page

* Button that shows location of selected bus station to user on Apple Maps

* Takes user's location to set departure point
  * If user denied permission, leads user to settings to open location services
  * If user's location is not in area of service, shows an alert
* Seat and gender selection through ALBusSeatView Pod

* Seeing available seats

* Searchbar to search for cities

* Error handlings
  * Can't choose same departure and destination
  * Can't see bought tickets if user hadn't bought one
  * Can't select past date
  * Can't get more than 5 seats at a time
* Regex for textfields
  * Name-Surname field
    * Can't type numbers
    * Name or Surname can't be one character
    * Can't type only name
    * Field can be 26 characters long max
  * Id field
    * Id should be 11 characters
    * Can't type letters
# Screen Records

## Full Review
// Fullreview record here
## Onboarding
// Onboarding record here
## Apple Maps
// Maps record here
## Location Services ( Granted Permission - In Service Area)
// In service area record here
## Location Services ( Granted Permission - Outside of Service Area)
// Out of Service Area record here
## Location Services ( Denied Permission )
// Not granted record here
