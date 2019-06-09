import java.time.LocalDate;

public class Expense {

	
	private int id;
	private String description;
	private double price;
	private Category category;
	private LocalDate date;
	private static int autoIncrement=0;
	//private Image image;

	public Expense(String description, double price, Category category,LocalDate date){
		id = autoIncrement;		
		autoIncrement++;
		this.description= description;
		this.price= price;
		this.category = category;
		this.date = date;
	}

	public Expense(String description, double price, Category category){
		id = autoIncrement;		
		autoIncrement++;
		this.description= description;
		this.price= price;
		this.category = category;
		this.date = LocalDate.now();
	}

	public int getId(){
		return id;
	}

	public String getDescription(){
		return description;
	}

	public double getPrice(){
		return price;
	}

	public LocalDate getDate(){
		return date;
	}

	public Category getCategory(){
		return category;
	}

	public void setDescription(String description){
		this.description=description;
	}

	public void setPrice(double price){
		this.price=price;
	}

	public void setDate(LocalDate date){
		this.date=date;
	}

	public void setCategory(Category category){
		this.category=category;
	}

	public String getString(){
		return "Description: " + description + ", price: " + price + ", category: " + category + ", date  " + date; 
	}

}
