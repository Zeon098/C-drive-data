package Flight;

import java.util.Scanner;



public class Admin extends User {
    public Admin(String username, String password, String phoneNumber) {
        super(username, password, phoneNumber);
    }

    @Override
    public String toString() {
        return username + "<N/>" + password + "<N/>" + phoneNumber + "<N/>" + "Admin";
    }

    @Override
    public void menu(DataBase dataBase, User user) {
        System.out.println("1. View Flights");
        System.out.println("2. Search Flight");
        System.out.println("3. Add Flight");
        System.out.println("4. Change Flight Schedule");
        System.out.println("5. Exit (Close this application)");

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
                addFlight(dataBase, this);
                break;
            case 4:
                changeFlightSchedule(dataBase, this);
            case 5:
                return;
            default:
                System.out.println("Enter valid input!");
                user.menu(dataBase, this);
        }
    }


    public void addFlight(DataBase dataBase, User user) {
        Scanner s = new Scanner(System.in);
        Flight flight = new Flight();
        System.out.println("\nEnter flight name: ");
        String name = s.next();
        flight.setFlightName(name);
        System.out.println("Enter Date DD/MM/YYYY: ");
        flight.setDate(s.next());
        System.out.println("Enter departure time: ");
        flight.setDepartureTime(s.next());
        System.out.println("Enter departure City/Country: ");
        flight.setDepartureLocation(s.next());
        System.out.println("Enter reaching time: ");
        flight.setReachingTime(s.next());
        System.out.println("Enter reaching City/Country: ");
        flight.setReachingLocation(s.next());
        System.out.println("Enter ticket charges: ");
        flight.setFlightPrice(s.nextDouble());
        dataBase.addFlight(flight);
        System.out.println("Flight Added successfully.\n");
        user.menu(dataBase, this);
        s.close();
    }
    public void changeFlightSchedule(DataBase dataBase,User user){
        System.out.println("\nEnter flight name: ");
        Scanner s=new Scanner(System.in);
        String flightName= s.next();
        int i = dataBase.getFlight(flightName);
        if(i>-1){
            dataBase.deleteFlight(i);
            System.out.println("Enter the Changings:");
            addFlight(dataBase, this);
        }else {
            System.out.println("Flight doesn't exist!\n");
        }

    }

}

