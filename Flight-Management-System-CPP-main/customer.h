#ifndef NORMALUSER_H
#define NORMALUSER_H

#include <iostream>

#include "User.h"
#include "DataBase.h"

class Customer : public User
{
public:
    Customer(const std::string &username, const std::string &password, const std::string &phoneNumber)
        : User(username, password, phoneNumber) {}

    void menu(DataBase &dataBase, User &user) override
    {
        int choice;
        do
        {
            std::cout << "1. View Flights" << std::endl;
            std::cout << "2. Search Flight" << std::endl;
            std::cout << "3. Book Flight" << std::endl;
            std::cout << "4. Cancel Flight" << std::endl;
            std::cout << "5. View Booked Flights" << std::endl;
            std::cout << "6. Exit" << std::endl;
            std::cout << "Enter your choice: ";
            std::cin >> choice;
            switch (choice)
            {
            case 1:
                viewFlights(dataBase, user);
                break;
            case 2:
                searchFlight(dataBase, user);
                break;
            case 3:
                bookFlight(dataBase, user);
                break;
            case 4:
                cancelFlight(dataBase, user);
                break;
            case 5:
                viewBookedFlights(dataBase, user);
                break;
            case 6:
                break;
            default:
                std::cout << "Invalid choice. Please try again." << std::endl;
            }
        } while (choice != 6);
    }

    void bookFlight(DataBase dataBase, User user) {

        string filghtName;
        
        cout<<"Enter Flight name: ";
        cin>> filghtName;
        int i = dataBase.getFlight(filghtName);
        if (i > -1) {
            Flight bookedFlight = dataBase.getFlight(i);
            dataBase.addBookedFlight(bookedFlight);
            dataBase.saveBookedFlight();
            cout<<"\nYou have booked a ticket from " + dataBase.getBookedFlight(i).getDepartureLocation()
                    + " to " + dataBase.getBookedFlight(i).getReachingLocation() + " on "
                    + dataBase.getBookedFlight(i).getDate() + " at " + dataBase.getBookedFlight(i).getDepartureTime() +
                    "\nEnjoy Your flight!\n";


        } else {
            cout<<"Flight doesn't exist!\n";
        }
        user.menu(dataBase, this);
    }

    void cancelTicket(DataBase dataBase, User user) {


        cout<<"Enter Flight name: ";
        string flightName ;
        cin>>flightName
        int i = dataBase.getBookedFlight(filghtName);
        if (i > -1) {
            Flight bookedFlight = dataBase.getFlight(i);
            dataBase.deleteBookedFlight(i);
            dataBase.saveBookedFlight();
            cout<<"\nYou have cancelled the ticket from " + dataBase.getBookedFlight(i).getDepartureLocation()
                    + " to " + dataBase.getBookedFlight(i).getReachingLocation() + " on "
                    + dataBase.getBookedFlight(i).getDate() + " at " + dataBase.getBookedFlight(i).getDepartureTime() +
                    "\nEnjoy Your flight!\n";
        } else {
            cout<<"You haven't booked this flight!\n";
        }
        user.menu(dataBase, this);
    }

    void viewBookedFlights(DataBase dataBase, User user) {
        vector<Flight> bookedFlights = dataBase.getAllBookedFlights();
        System.out.println("Name\t\t\t\t\tDate\t\tDeparture Time\t\t\t\tCity/Country\t\t\tReaching Time\t\tCity/Country\t\tPrice");
        for (Flight f : bookedFlights) {
            cout<<f.getFlightName() + "\t\t" + f.getDate() + "\t\t\t" + f.getDepartureTime() + "\t\t\t\t\t" + f.getDepartureLocation() + "\t\t\t\t" + f.getReachingTime() + "\t\t\t" + f.getReachingLocation() + "\t\t\t" + f.getFlightPrice();
        }
        
        user.menu(dataBase, this);
    }

};

#endif // NORMALUSER_H