package Flight;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.PrintWriter;
import java.util.ArrayList;

public class DataBase {

    private ArrayList<User> users = new ArrayList<User>();
    private ArrayList<Flight> flights = new ArrayList<Flight>();
    private ArrayList<Flight> bookedFlights = new ArrayList<Flight>();

    private File usersfile = new File("C:\\Users\\Lenovo\\Desktop\\Flight Management System\\src\\Data\\Users");
    private File flightsfile = new File("C:\\Users\\Lenovo\\Desktop\\Flight Management System\\src\\Data\\Flights");
    private File bookedFlightsfile = new File("C:\\Users\\Lenovo\\Desktop\\Flight Management System\\src\\Data\\Booked Flights");
    private File folder = new File("C:\\Users\\Lenovo\\Desktop\\Flight Management System\\src\\Data");

    public DataBase() {
        if (!folder.exists()) {
            folder.mkdirs();
        }
        if (!usersfile.exists()) {
            try {
                usersfile.createNewFile();
            } catch (Exception e) {
                System.out.println("user file cannot created");
            }

        }
        if (!flightsfile.exists()) {
            try {
                flightsfile.createNewFile();
            } catch (Exception e) {
            }

        }
        if (!bookedFlightsfile.exists()) {
            try {
                bookedFlightsfile.createNewFile();
            } catch (Exception e) {
            }

        }
        getUsers();
        getFlight();
        getBookedFlight();

    }

    public void addUser(User s) {
        users.add(s);
        saveUsers();
    }
    private void saveFlight() {
        String text1 = "";
        for (Flight flight : flights) {
            text1 = text1 + flight.toString2() + "<NewFlight/>\n";
        }
        try {
            PrintWriter pw = new PrintWriter(flightsfile);
            pw.print(text1);
            pw.close();
        } catch (Exception e) {
            System.err.println(e.toString());
        }
    }
    public void saveBookedFlight() {
        String text1 = "";
        for (Flight flight : flights) {
            text1 = text1 + flight.toString2() + "<NewFlight/>\n";
        }
        try {
            PrintWriter pw = new PrintWriter(bookedFlightsfile);
            pw.print(text1);
            pw.close();
        } catch (Exception e) {
            System.err.println(e.toString());
        }
    }
    public void addBookedFlight(Flight f) {
        flights.add(f);
        saveBookedFlight();
    }

    private void saveUsers() {
        String text1 = "";
        for (User user : users) {
            text1 = text1 + user.toString() + "<NewUser/>\n";
        }
        try {
            PrintWriter pw = new PrintWriter(usersfile);
            pw.print(text1);
            pw.close();
        } catch (Exception e) {
            System.err.println(e.toString());
        }
    }
    public void addFlight(Flight f) {
        flights.add(f);
        saveFlight();
    }

    public void deleteBookedFlight(int i) {
        bookedFlights.remove(i);
        saveBookedFlight();
    }
    public int getBookedFlight(String flightName) {
        for (Flight flight : flights) {
            if (flight.getFlightName().equals(flightName))
            {
                return flights.indexOf(flight);
            }
        }
        return -1;
    }
    public Flight getBookedFlight(int i) {
        return bookedFlights.get(i);
    }
    private void getBookedFlight() {
        String text1 = "";
        try {
            BufferedReader br1 = new BufferedReader(new FileReader(bookedFlightsfile));
            String s1;
            while ((s1 = br1.readLine()) != null) {
                text1 = text1 + s1;
            }
            br1.close();
        } catch (Exception e) {
            System.err.println(e.toString());
        }
        if (!text1.matches("") || !text1.isEmpty()) {
            String[] a1 = text1.split("<NewFlight/>");
            for (String s : a1) {
                Flight flight = parseFlight(s);
                bookedFlights.add(flight);
            }

        }
    }

    private void getFlight() {
        String text1 = "";
        try {
            BufferedReader br1 = new BufferedReader(new FileReader(flightsfile));
            String s1;
            while ((s1 = br1.readLine()) != null) {
                text1 = text1 + s1;
            }
            br1.close();
        } catch (Exception e) {
            System.err.println(e.toString());
        }
        if (!text1.matches("") || !text1.isEmpty()) {
            String[] a1 = text1.split("<NewFlight/>");
            for (String s : a1) {
                Flight flight = parseFlight(s);
                flights.add(flight);
            }

        }
    }


    public Flight parseFlight(String s) {
        String[] a = s.split("<N/>");
        Flight flight = new Flight();
        flight.setFlightName(a[0]);
        flight.setDate(a[1]);
        flight.setDepartureTime(a[2]);
        flight.setDepartureLocation(a[3]);
        flight.setReachingTime(a[4]);
        flight.setReachingLocation(a[5]);
        flight.setFlightPrice(Double.parseDouble(a[6]));
        return flight;
    }
    public ArrayList<Flight> getAllFlights() {
        return flights;
    }
    public ArrayList<Flight> getAllBookedFlights() {
        return bookedFlights;
    }



    public void deleteFlight(int i) {
        flights.remove(i);
        saveFlight();
    }
    public int getFlight(String flightName) {
        for (Flight flight : flights) {
            if (flight.getFlightName().equals(flightName))
            {
                return flights.indexOf(flight);
            }
        }
        return -1;
    }
    public Flight getFlight(int i) {
        return flights.get(i);
    }

    public boolean userExists(String name) {
        boolean f = false;
        for (User user : users) {
            if (user.getUsername().toLowerCase().matches(name.toLowerCase())) {
                f = true;
                break;
            }
        }
        return f;
    }

    public int login(String username, String password) {
        int n = -1;
        for (User s : users) {
            if (s.getPassword().matches(password) && s.getUsername().matches(username)) {
                n = users.indexOf(s);
                break;
            }
        }
        return n;
    }



    public User getUser(int n) {
        return users.get(n);
    }

    private void getUsers() {
        String text1 = "";
        try {

            BufferedReader br1 = new BufferedReader(new FileReader(usersfile));
            String s1;
            while ((s1 = br1.readLine()) != null) {
                text1 = text1 + s1;
            }
            br1.close();
        } catch (Exception e) {
            System.err.println(e.toString());
        }
        if (!text1.matches("") || !text1.isEmpty()) {
            String[] a1 = text1.split("<NewUser/>");
            for (String s : a1) {
                String[] a2 = s.split("<N/>");
                if (a2[3].matches("Admin")) {
                    User user = new Admin(a2[0], a2[1], a2[2]);
                    users.add(user);
                } else {
                    User user = new NormalUser(a2[0], a2[1], a2[2]);
                    users.add(user);
                }
            }

        }
    }
}
