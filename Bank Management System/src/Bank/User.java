package Bank;

import java.util.ArrayList;
import java.util.Scanner;

public abstract class User extends Account {

    public User(String username, String password) {
        super(username,password);

    }
    public User(String username, String password,String accNo,int balance) {
        super(username, password, accNo, balance);
    }



    abstract public String toString();

    abstract public void menu(DataBase dataBase, User user);
}

