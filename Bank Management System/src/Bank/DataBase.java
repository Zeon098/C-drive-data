package Bank;

import javax.print.DocFlavor;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.PrintWriter;
import java.util.ArrayList;

public class DataBase {


    private ArrayList<User> users = new ArrayList<User>();
    private ArrayList<Account> accounts = new ArrayList<Account>();

    private File usersfile = new File("C:\\Users\\Lenovo\\Desktop\\Bank Management System\\src\\Data\\Users");
    private File accountfile = new File("C:\\Users\\Lenovo\\Desktop\\Bank Management System\\src\\Data\\Accounts");
    private File folder = new File("C:\\Users\\Lenovo\\Desktop\\Bank Management System\\src\\Data");

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
        if (!accountfile.exists()) {
            try {
                accountfile.createNewFile();
            } catch (Exception e) {
                System.out.println("Account file cannot created");
            }

        }
        getUsers();
        getAccounts();
    }

    public void saveAccounts() {
        String text1 = "";
        for (Account account : accounts) {
            text1 = text1 + account.toString2() + "<NewAccount/>\n";
        }
        try {
            PrintWriter pw = new PrintWriter(accountfile);
            pw.print(text1);
            pw.close();
        } catch (Exception e) {
            System.err.println(e.toString());
        }
    }

    private void getAccounts() {
        String text1 = "";
        try {
            BufferedReader br1 = new BufferedReader(new FileReader(accountfile));
            String s1;
            while ((s1 = br1.readLine()) != null) {
                text1 = text1 + s1;
            }
            br1.close();
        } catch (Exception e) {
            System.err.println(e.toString());
        }
        if (!text1.matches("") || !text1.isEmpty()) {
            String[] a1 = text1.split("<NewAccount/>");
            for (String s : a1) {
                Account account = parseAccount(s);
                accounts.add(account);
            }
        }
    }

    public Account parseAccount(String s) {
        String[] a = s.split("<N/>");
        Account account = new Account();
        account.setUsername(a[0]);
        account.setPassword(a[1]);
        account.setAccNo(a[2]);
        account.setBalance(Integer.parseInt(a[3]));

        return account;
    }

    public ArrayList<Account> getAllAccounts() {
        return accounts;
    }
    public int getAccount(String bookname) {
        int i = -1;
        for (Account account : accounts) {
            if (account.getUsername().matches(bookname)) ;
            {
                i = accounts.indexOf(account);
            }
        }
        return i;
    }
    public void AddAccount(Account account) {
        accounts.add(account);
        saveAccounts();

    }
    public void deleteAccount(int i) {
        accounts.remove(i);
        saveAccounts();
    }

    public void addUser(User s) {
        users.add(s);
        saveUsers();
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

    public User getUser(int n) {
        return users.get(n);
    }

    public int getUser(String username) {
        int i = -1;
        for (User user : users) {
            if (user.getUsername().matches(username)) ;
            {
                i = users.indexOf(user);
            }
        }
        return i;
    }

    public void deleteUser(int i) {
        users.remove(i);
        saveUsers();
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
                if (a2[2].matches("Manager")) {
                    User user = new Manager(a2[0], a2[1]);
                    users.add(user);
                } else {
                    User user = new NormalUser(a2[0], a2[1]);
                    users.add(user);
                }
            }

        }
    }
}


