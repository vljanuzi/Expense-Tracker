

import java.util.ArrayList;
import java.util.Map;
import java.util.Set;
import java.util.HashMap;

public class ExpenseTracker{

	private ArrayList<Account> accounts;
	private ArrayList<Category> categories;

	public ExpenseTracker(){
		accounts = new ArrayList<Account>();
		categories = new ArrayList<Category>();
 
	}

	public void addAccount(Account account){
		accounts.add(account);
	}

	public void removeAccount(Account account){
		accounts.remove(account);
	}

	public void addCategory(Category category){
		categories.add(category);
	}

	public void addExpense(String nameOfAccount,String description, double price, Category category){
		Account account = getAccountWithName(nameOfAccount);
		account.addExpense(description,price,category);
	}

	public void transferMoney(String nameOfSendingAccount,String nameOfRecievingAccount,double amount){
		Account accountSending = getAccountWithName(nameOfSendingAccount);
		Account accountRecieving = getAccountWithName(nameOfRecievingAccount);

		accountSending.transferMoney(accountRecieving,amount);
	}

	public Account getAccountWithName(String nameOfAccount){

		for(Account account: accounts){
			if(account.getName().equals(nameOfAccount)){
				return account;
			}
		}

		return null;
	}


  public Category getCategoryWithName(String nameOfCategory){

    for(Category category: categories){
      if(category.getName().equals(nameOfCategory)){
        return category;
      }
    }

    return null;
  }

	public double totalExpenses(){
		double totalExpenses = 0 ;
		for(Account account:accounts){
			totalExpenses+=account.getTotalExpenses();
		}

		return totalExpenses;
	}

	public double totalAmount(){
		double totalAmount = 0;
		for(Account account:accounts){
			totalAmount+=account.getAmount();
		}

		return totalAmount;
	}

	public int numberOfTotalExpenses(){
		int numberOfTotalExpenses = 0;

		for(Account account:accounts){
			numberOfTotalExpenses = account.getNumberOfExpenses();
		}

		return numberOfTotalExpenses;
	}

	public void informationForAccount(String nameOfAccount){
		Account account = getAccountWithName(nameOfAccount);
		System.out.println(account.toString());
	}


	public Expense getExpense(String nameOfAccount,int id){
		Account account = getAccountWithName(nameOfAccount);
		return account.getExpense(id);
	}

	public Map<Integer,Double> yearlyExpense(){
		Map<Integer,Double> map = new HashMap<Integer,Double>();

		for(int i=0;i<accounts.size();i++){
			for(Expense expense: accounts.get(i).getExpenses() ){
				int year =  expense.getDate().getYear();
				if(map.containsKey(year)){
					double totalYear = map.get(year);
					totalYear+=expense.getPrice();
					map.put(year,totalYear);
				}else{
					map.put(year,expense.getPrice());
				}
			}			
		}


		return map;
	}

	public Map<Category,Double> expensesByCategories(){
		Map<Category,Double> map = new HashMap<Category,Double>();

		for(int i=0;i<accounts.size();i++){
			for(Expense expense: accounts.get(i).getExpenses() ){

				Category category =  expense.getCategory();
				if(map.containsKey(category)){
					double totalCategory = map.get(category);
					totalCategory+=expense.getPrice();
					map.put(category,totalCategory);
				}else{
					map.put(category,expense.getPrice());
				}
			}			
		}

		return map;
	}

	public Map<Category,Double> expensesByCategories(int month){
		Map<Category,Double> map = new HashMap<Category,Double>();

		for(int i=0;i<accounts.size();i++){
			for(Expense expense: accounts.get(i).getExpenses() ){

				if(expense.getDate().getMonthValue() == month ){
					Category category =  expense.getCategory();
					if(map.containsKey(category)){
						double totalCategory = map.get(category);
						totalCategory+=expense.getPrice();
						map.put(category,totalCategory);
					}else{
						map.put(category,expense.getPrice());
					}					
				}

			}			
		}

		return map;
	}
	public void printExpensesByCategories(){
		Map<Category,Double> map = expensesByCategories();
		
		Set<Category> key = map.keySet();

		for(Category category: key){
			System.out.println(category + ": " + map.get(category));
		}
	}		

	public void printYearlyExpense(){
		Map<Integer,Double> map = yearlyExpense();
		
		Set<Integer> key = map.keySet();

		for(Integer year: key){
			System.out.println(year + ": " + map.get(year));
		}
	}


	public int sizeOfAccounts() {
		return accounts.size();
	}

	public Account getAccount(int i) {
		return accounts.get(i);
	}



}
