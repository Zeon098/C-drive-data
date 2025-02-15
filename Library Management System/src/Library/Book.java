package Library;

import java.util.ArrayList;

public class Book {
    private String name;
    private String author;
    private String publisher;
    private String adress;          // collection Address
    private String status;          // borrow status
    private int qty;                // copies for sale
    private double price;
    private int brwcopies;          // copies for borrowing

    public Book() {};
    public Book(String name,String author, String publisher,String adress,
                int qty,double price,int brwcopies){
        this.name=name;
        this.author= author;
        this.publisher=publisher;
        this.adress=adress;
        this.qty=qty;
        this.price=price;
        this.brwcopies=brwcopies;

    }
    public String toString()
    {
        String text="Book Name: "+name+"\n"+
                "Book Author: "+author+"\n"+
                "Book publisher: "+ publisher+"\n"+
                "Book collection Address: "+adress+"\n"+
                "Qty: "+ String.valueOf(qty)+"\n"+
                "Price: "+ String.valueOf(price)+"\n"+
                "Borrow Copies:  "+ String.valueOf(brwcopies);
        return text;
    }
    public String getName(){
        return name;
    }
    public void setName(String name)
    {
        this.name= name ;
    }
    public String getAuthor(){
        return author;
    }
    public void setAuthor(String author){
        this.author=author;
    }
    public String getPublisher(){
        return publisher;
    }
    public void setPublisher(String publisher){
        this.publisher=publisher;
    }
    public String getAdress(){
        return adress;
    }
    public void setAdress(String adress){
        this.adress=adress;
    }
    public String getStatus()
    {
        return status;
    }
    public void setStatus(String status){
        this.status=status;
    }
    public int getQty(){
        return qty;
    }
    public void setQty(int qty){
        this.qty=qty;
    }
    public double getPrice(){
        return price;
    }
    public void setPrice(double price){
        this.price=price;
    }
    public int getBrwcopies(){
        return brwcopies;
    }
    public void setBrwcopies(int brwcopies){
        this.brwcopies=brwcopies;
    }

    public String toString2(){
        String text=name+ "<N/>"+author+ "<N/>"+ publisher+ "<N/>"+adress+
                "<N/>"+ String.valueOf(qty)+ "<N/>"+ String.valueOf(price)+
                "<N/>"+ String.valueOf(brwcopies);
        return text;
    }
}
