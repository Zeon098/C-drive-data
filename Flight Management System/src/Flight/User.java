package Flight;

import java.util.ArrayList;
import java.util.Scanner;

abstract public class User {
    protected String username;
    protected String password;
    protected String phoneNumber;
//        protected IOOperation[] operations;


    public User(String username, String password, String phoneNumber) {
        this.username = username;
        this.password = password;
        this.phoneNumber = phoneNumber;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void viewflights(DataBase dataBase, User user) {
        ArrayList<Flight> flights = dataBase.getAllFlights();
        System.out.println("Name\t\t\t\t\tDate\t\tDeparture Time\t\t\t\tCity/Country\t\t\tReaching Time\t\tCity/Country\t\tPrice");
        for (Flight f : flights) {
            System.out.println(f.getFlightName() + "\t\t" + f.getDate() + "\t\t\t" + f.getDepartureTime() + "\t\t\t\t\t" + f.getDepartureLocation() + "\t\t\t\t" + f.getReachingTime() + "\t\t\t" + f.getReachingLocation() + "\t\t\t" + f.getFlightPrice());
        }
        System.out.println();
        user.menu(dataBase, this);
    }

    public void searchFlight(DataBase dataBase, User user) {
        System.out.println("\nEnter flight name: ");
        Scanner s = new Scanner(System.in);
        String name = s.next();
        int i = dataBase.getFlight(name);
        if (i > -1) {
            System.out.println(i);
            System.out.println("\n" + dataBase.getFlight(i).toString() + "\n");
        } else {
            System.out.println("Flight doesn't exist!\n");
        }

        user.menu(dataBase, this);
    }


    abstract public String toString();

    abstract public void menu(DataBase dataBase, User user);
}
