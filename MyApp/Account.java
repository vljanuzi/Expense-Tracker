import java.util.ArrayList;
import java.time.LocalDate;


public class Account{
	
	private ArrayList<Expense> expenseList;
	private String name;
	private double amount;
	private double totalExpenses;

	public Account(String name,double amount){
		this.name = name;
		this.amount = amount;
		totalExpenses = 0;
		expenseList = new ArrayList<Expense>();
	}

	public String getName(){
		return name;
	}

	public double getAmount(){
		return amount;
	}

	public void setName(String name){
		this.name = name;
	}

	public void addAmount(double amount){
		this.amount+=amount;
	}

	public void removeAmount(double amount){
		this.amount-=amount;
	}

	public void setAmount(double amount){
		this.amount = amount;
	}

	public double getTotalExpenses(){
		return totalExpenses;
	}


	public void addExpense(String description, double price, Category category){
		if(amount-price>0){
			Expense expense = new Expense(description,price,category);
			expenseList.add(expense);
			removeAmount(price);
			totalExpenses+=price;

		}else{
			System.out.println("You cannot make the expense");
		}

	}


	public void addExpense(String description, double price, Category category,LocalDate date){
		if(amount-price>0){
			Expense expense = new Expense(description,price,category,date);
			expenseList.add(expense);
			removeAmount(price);
			totalExpenses+=price;			
		}else{
			System.out.println("You cannot make the expense");
		}

	}

	public void removeExpense(Expense expense){
		expenseList.remove(expense);
		addAmount(expense.getPrice());
		totalExpenses-=expense.getPrice();
	}

	public ArrayList<Expense> getExpenses(){
		return expenseList;
	}

	public void transferMoney(Account anotherAccount,double amountTransfer){
		if(amount-amountTransfer>0){
			anotherAccount.addAmount(amountTransfer);
			removeAmount(amountTransfer);
		}else{
			System.out.println("You cannot make the transaction");
		}
	}

	public Expense getExpense(int id){
		return expenseList.get(id);
	}

	public int getNumberOfExpenses(){
		return expenseList.size();
	}

	public String toString(){
		return "Name of account is " + this.name + ", amount available is " + amount +  ", and expenses amount is " + totalExpenses;
	}
}