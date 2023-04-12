# BusTicket

An iOS app that simulates a ticket reservation system. Made with UIKit

## Functions

* Onboarding page
  * Shows up only on first launch

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

https://user-images.githubusercontent.com/87566024/231261078-f2c7b31f-d0f6-4bb0-8d50-08cda9b7543d.mp4


## Onboarding



https://user-images.githubusercontent.com/87566024/231261424-eea393b6-e2c3-4bec-8d97-6e07c6692b26.mp4



## Apple Maps



https://user-images.githubusercontent.com/87566024/231261549-b0957002-3594-4b4b-a487-b2ceabbb9080.mp4



## Location Services ( Granted Permission - In Service Area)
Device's custom location is on Eskişehir


https://user-images.githubusercontent.com/87566024/231261718-04756aac-50ec-48ae-b6b8-bf35e6208a31.mp4



## Location Services ( Granted Permission - Outside of Service Area)



https://user-images.githubusercontent.com/87566024/231261904-2cb788bc-eb74-4682-a9c6-80790286a451.mp4



## Location Services ( Denied Permission )


https://user-images.githubusercontent.com/87566024/231262024-c836d1e2-c4d4-416f-bd8d-0b40dec22ab5.mp4


