package Flight;

public class Ticket {
    private String flightName;
    private String date;
    private String departureTime;
    private String departureLocation;
    private String reachingTime;
    private String reachingLocation;
    private double flightPrice;

    public Ticket(){};
    public Ticket( String flightName,String date,String departureTime,String departureLocation,String reachingTime,
                   String reachingLocation,double flightPrice) {
        this.flightName = flightName;
        this.date=date;
        this.departureTime = departureTime;
        this.departureLocation = departureLocation;
        this.reachingTime = reachingTime;
        this.reachingLocation = reachingLocation;
        this.flightPrice = flightPrice;
    }

    public String toString()
    {
        String text="Flight Name: "+flightName+"\n"+
                "Date: "+date+"\n"+
                "Departure Time: "+departureTime+"\n"+
                "Departure Location: "+ departureLocation+"\n"+
                "Reaching Time: "+reachingTime+"\n"+
                "Reaching Location "+ reachingLocation+"\n"+
                "Price: "+ flightPrice;
        return text;
    }

    public String getFlightName() {
        return flightName;
    }

    public void setFlightName(String flightName) {
        this.flightName = flightName;
    }
    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(String departureTime) {
        this.departureTime = departureTime;
    }

    public String getDepartureLocation() {
        return departureLocation;
    }

    public void setDepartureLocation(String departureLocation) {
        this.departureLocation = departureLocation;
    }

    public String getReachingTime() {
        return reachingTime;
    }

    public void setReachingTime(String reachingTime) {
        this.reachingTime = reachingTime;
    }

    public String getReachingLocation() {
        return reachingLocation;
    }

    public void setReachingLocation(String reachingLocation) {
        this.reachingLocation = reachingLocation;
    }

    public double getFlightPrice() {
        return flightPrice;
    }

    public void setFlightPrice(double flightPrice) {
        this.flightPrice = flightPrice;
    }

    public String toString2(){
        String text=flightName+ "<N/>"+date+ "<N/>"+departureTime+ "<N/>"+ departureLocation+ "<N/>"+reachingTime+
                "<N/>"+ reachingLocation+ "<N/>"+flightPrice ;
        return text;
    }
}
