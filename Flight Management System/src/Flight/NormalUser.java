package Flight;

import java.util.ArrayList;
import java.util.Scanner;

public class NormalUser extends User {


    public NormalUser(String username, String password, String phoneNumber) {
        super(username, password, phoneNumber);
    }

    @Override
    public String toString() {
        return username + "<N/>" + password + "<N/>" + phoneNumber + "<N/>" + "Normal";
    }

    @Override
    public void menu(DataBase dataBase, User user) {
        System.out.println("1. View Flights");
        System.out.println("2. Search Flight");
        System.out.println("3. Book Ticket");
        System.out.println("4. Cancel Tickets");
        System.out.println("5. View Booked Tickets");
        System.out.println("6. Exit (Close this application)");
        Scanner s = new Scanner(System.in);
        int n = s.nextInt();
        switch (n) {
            case 1:
                viewflights(dataBase, this);
                break;
            case 2:
                searchFlight(dataBase, this);
                break;
            case 3:
                bookFlight(dataBase, this);
            case 4:
                cancelTicket(dataBase, this);
            case 5:
                viewBookedFlights(dataBase, this);
            case 6:
                return;
            default:
                System.out.println("Enter valid input!");
                user.menu(dataBase, this);
        }
    }

    public void bookFlight(DataBase dataBase, User user) {


        Scanner s = new Scanner(System.in);
        System.out.println("Enter Flight name: ");
        String filghtName = s.next();
        int i = dataBase.getFlight(filghtName);
        if (i > -1) {
            Flight bookedFlight = dataBase.getFlight(i);
            dataBase.addBookedFlight(bookedFlight);
            dataBase.saveBookedFlight();
            System.out.println("\nYou have booked a ticket from " + dataBase.getBookedFlight(i).getDepartureLocation()
                    + " to " + dataBase.getBookedFlight(i).getReachingLocation() + " on "
                    + dataBase.getBookedFlight(i).getDate() + " at " + dataBase.getBookedFlight(i).getDepartureTime() +
                    "\nEnjoy Your flight!\n");


        } else {
            System.out.println("Flight doesn't exist!\n");
        }
        user.menu(dataBase, this);
    }

    public void cancelTicket(DataBase dataBase, User user) {


        Scanner s = new Scanner(System.in);
        System.out.println("Enter Flight name: ");
        String filghtName = s.next();
        int i = dataBase.getBookedFlight(filghtName);
        if (i > -1) {
            Flight bookedFlight = dataBase.getFlight(i);
            dataBase.deleteBookedFlight(i);
            dataBase.saveBookedFlight();
            System.out.println("\nYou have cancelled the ticket from " + dataBase.getBookedFlight(i).getDepartureLocation()
                    + " to " + dataBase.getBookedFlight(i).getReachingLocation() + " on "
                    + dataBase.getBookedFlight(i).getDate() + " at " + dataBase.getBookedFlight(i).getDepartureTime() +
                    "\nEnjoy Your flight!\n");
        } else {
            System.out.println("You haven't booked this flight!\n");
        }
        user.menu(dataBase, this);
    }
    public void viewBookedFlights(DataBase dataBase, User user) {
        ArrayList<Flight> bookedFlights = dataBase.getAllBookedFlights();
        System.out.println("Name\t\t\t\t\tDate\t\tDeparture Time\t\t\t\tCity/Country\t\t\tReaching Time\t\tCity/Country\t\tPrice");
        for (Flight f : bookedFlights) {
            System.out.println(f.getFlightName() + "\t\t" + f.getDate() + "\t\t\t" + f.getDepartureTime() + "\t\t\t\t\t" + f.getDepartureLocation() + "\t\t\t\t" + f.getReachingTime() + "\t\t\t" + f.getReachingLocation() + "\t\t\t" + f.getFlightPrice());
        }
        System.out.println();
        user.menu(dataBase, this);
    }
}

