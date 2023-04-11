# BusTicket

<details>
           <summary>Error Handlings</summary>
           <p>-Abc</p>
         </details>


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
