package Bank;

public class Account {
    protected String username;
    protected String password;
    protected String accNo;
    protected int balance;

    public Account() {}
    public Account(String username, String password) {
        this.username=username;
        this.password= password;
    }
    public Account(String username,String password,String accNo ,int balance){
        this.username=username;
        this.password= password;
        this.accNo=accNo;
        this.balance=balance;
    }



    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getBalance() {
        return balance;
    }

    public void setBalance(int balance) {
        this.balance = balance;
    }

    public String getAccNo() {
        return accNo;
    }

    public void setAccNo(String accNo) {
        this.accNo = accNo;
    }

    public String toString()
    {
        String text="Account Name: "+username+"\n"+
                "Account Password: "+password+"\n"+
                "Account Number: "+accNo+"\n"+
                "Account Balance: "+ String.valueOf(balance)+"\n";

        return text;
    }

    public String toString2(){
        String text=username+ "<N/>"+password+ "<N/>"+ accNo+"<N/>"+String.valueOf(balance)+ "<N/>";
        return text;
    }
}


