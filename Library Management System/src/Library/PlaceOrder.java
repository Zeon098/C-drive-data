package Library;

import java.util.Scanner;
import java.util.SimpleTimeZone;

public class PlaceOrder implements IOOperation{
    @Override
    public void oper(DataBase dataBase,User user) {
        Order order= new Order();
        System.out.println("\nEnter book name: ");
        Scanner s=new Scanner(System.in);
        String bookname=s.next();
        int i= dataBase.getBook(bookname);
        if(i<=-1){
            System.out.println("book doesn't exist!");
        }else {
            Book book=dataBase.getBook(i);
            order.setBook(book);
            order.setUser(user);
            System.out.println("Enter Qty: ");
            int qty= s.nextInt();
            order.setQty(qty);
            order.setPrice(book.getPrice()*qty);
            int bookIndex=dataBase.getBook(book.getName());
            book.setQty(book.getQty()-qty);
            dataBase.addOrder(order,book,bookIndex);
            System.out.println("Order placed successfully!\n");
        }
        user.menu(dataBase);
    }
}
