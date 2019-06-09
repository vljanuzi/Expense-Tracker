
import java.util.Date;
import controlP5.*;
import ketai.sensors.*;
import ketai.ui.*;

public class AddExpense extends GUIGridLayout {
  

  private GUILabel labelTitle;
  private GUILabel labelAccount;
  
  private GUITextField accountTF;
  private GUITextField valueTF;
  private GUITextField dateTF;
  private GUITextField categoryTF;
  private GUITextField descriptionTF;
  private GUIButton addButton;
  private GUIImage backButton;
  private String selected;
  private GUIToggle toggle;
  private GUIToggle toggleAccounts;
  private GUILabel location;
  private GUIImage nextAccount;
  private GUIImage previousAccount;
  //ScrollableList scrolist;

//temp vars
int copies =1;
int minP = 1;
int maxP = 1;
int mpp = 20;
Date date = new Date();

/*void dropdown(int index) {
  selected = (String)cp5.get(ScrollableList.class, "dropdown").getItem(index).get("value");

}*/

  AddExpense() {
    super(12, 0.5);

    Category category = core.getCategoryWithName("Food");
              core.addExpense("Bank", "test", 50.2, category);
              core.addExpense("Bank", "test", 50.1, category);
              core.addExpense("Bank", "test", 50.3, category);
              
    labelTitle = new GUILabel("Add Expense")
      .setAlignment(LEFT, CENTER)
      .setLabelColor(black)
      .drawBorder(false)
      .setLabelSize(20)
      .setBGColor(black);
      ;
      
    toggleAccounts = new GUIToggle("Wallet")
    .addState("bank")
    .drawBorder(false)
    .drawBG(false)
    .addBehaviour(
      new GUIBehaviour(toggle) {
        public void act(int e) {
          if (e==MOUSEPRESS) {
            //app.addToCollection("Chess",2, 2, 30);
            //toggleAccounts.previousStateText();
            println("TESTING TOGGLEEEEEEEEEEEEEEEEEEEE" + toggle.getState());
          }
        }
      }
    )
    ;     
        
    labelAccount = new GUILabel(toggleAccounts.getToggleState(0).getText())
      .setAlignment(LEFT, CENTER)
      .setLabelColor(black)
      .drawBorder(false)
      .setLabelSize(20)
      .setBGColor(black);
      ;    
    
     previousAccount = new GUIImage()  
    .setImage("previousarrow.png")
    .drawBG(true)
    .setBGColor(blue)
    .addBehaviour(
      new GUIBehaviour(previousAccount) {
        public void act(int e) {
          if (e==MOUSEPRESS) {
            toggleAccounts.previousStateText();
          }
        }
      }
    )
    ; 
    
     nextAccount = new GUIImage()  
    .setImage("forwardarrow.png")
    .drawBG(true)
    .setBGColor(blue)
    .addBehaviour(
      new GUIBehaviour(nextAccount) {
        public void act(int e) {
          if (e==MOUSEPRESS) {
            //app.addToCollection("Chess",2, 2, 30);
            toggleAccounts.nextStateText();
          }
        }
      }
    )
    ;
    ///////////////////////////////////////////////  
      /*
       accountTF = new GUITextField()
      .setPosition(100, 100)
      .setSize(200, 75)
      .setBGColor(white)
      .setLabel("Account")
      .setBorderColor(color(210, 213, 219))
      .setLabelSize(20)
      ;


         
    GUIBehaviour accountTFBehaviour = new GUIBehaviour(accountTF) {
      public void act(int e) {
        if (e==KEYPRESS) {
          accountTF.keyRegister(key);
        } else if (e==MOUSEPRESS) {
         KetaiKeyboard.toggle(app);

        }
      }
    };

    accountTF.addBehaviour(accountTFBehaviour);
  */
    /////////////////////////////////////////

    valueTF = new GUITextField()
      .setPosition(100, 100)
      .setSize(200, 75)
      .setBGColor(white)
      .setBorderColor(color(210, 213, 219))
      .setLabel("Value")
      .setLabelSize(20)
      ;

    
    GUIBehaviour labelTitleTFBehaviour = new GUIBehaviour(valueTF) {
      public void act(int e) {
        if (e==KEYPRESS) {
          valueTF.keyRegister(key);
        } else if (e==MOUSEPRESS) {
          KetaiKeyboard.toggle(app);
        }
      }
    };

    valueTF.addBehaviour(labelTitleTFBehaviour);

    ///////////////////////////////////////////////

      
       categoryTF = new GUITextField()
      .setPosition(100, 100)
      .setSize(200, 75)
      .setBGColor(white)
      .setLabel("Category")
      .setBorderColor(color(210, 213, 219))
      .setLabelSize(20)
      ;

    GUIBehaviour categoryTFBehaviour = new GUIBehaviour(categoryTF) {
      public void act(int e) {
        if (e==KEYPRESS) {
          categoryTF.keyRegister(key);
        } else if (e==MOUSEPRESS) {
          
          KetaiKeyboard.toggle(app);
        }
      }
    };

    categoryTF.addBehaviour(categoryTFBehaviour);

    ///////////////////////////////////////////////

    descriptionTF = new GUITextField()
      .setPosition(100, 100)
      .setSize(200, 75)
      .setBGColor(white)
      .setBorderColor(color(210, 213, 219))
      .setLabel("Description")
      .setLabelSize(20)
      ;

    GUIBehaviour descriptionTFBehaviour = new GUIBehaviour(descriptionTF) {
      public void act(int e) {
        if (e==KEYPRESS) {
          descriptionTF.keyRegister(key);
        } else if (e==MOUSEPRESS) {
          KetaiKeyboard.toggle(app);
        }
      }
    };

    descriptionTF.addBehaviour(descriptionTFBehaviour);


    ///////////////////////////////////////////////


  
    ///////////////////////////////////////////////

    addButton = new GUIButton(ANDROID)
     //.GUIButton setPressedColor(color c)
    .setLabel("Add expense")            
         //After the element is added to a GUITileLayout or a GUIGridLayout, it will be called automatically    
    .setBGColor(orange)
    .setLabelColor(white)
    .setLabelSize(30)   
    .drawBorder(false)
    .drawBG(true)
    .drawLabel(false)  
   ;
    
    GUIBehaviour addButtonBehaviour = new GUIBehaviour(addButton) {
      public void act(int e) {
        if (e==MOUSEPRESS) {
          
            
            //selected = cp5.get(ScrollableList.class, "dropdown").getItem(n).get("value");
            //System.out.println(selected);
              String accountName = accountTF.read();
              String expenseDescription = descriptionTF.read();
              String expenseCategory = categoryTF.read();
              int expenseValue = Integer.parseInt(valueTF.read());
              
              //Account account = core.getAccountWithName(accountName);
              /*Category category = core.getCategoryWithName(expenseCategory);
              System.out.println(accountName);
              System.out.println(expenseDescription);
              System.out.println(expenseCategory);
              System.out.println(expenseValue);
              
              core.addExpense(accountName, expenseDescription, Double.parseDouble(expenseValue), category); */
              

              expenses = new Expenses();
              accounts = new Accounts();
              
              if (db.connect()) {
                if (!db.tableExists("expenses")) 
                    db.execute(create_table_expenses);
                
                println("data count for expenses table: " + db.getRecordCount("expenses"));
                
                if (!db.execute("INSERT into expenses (`description`, `price`) VALUES ('"+expenseDescription+"', "+expenseValue+")")) 
                    println("error w/sql insert");
                    
                println("data count for expenses table after insert" + db.getRecordCount("expenses"));
                
              }
              
              db.query("SELECT * FROM expenses");
              
              while (db.next()) {
                 println(db.getString("description"));
              }
            
              
              KetaiAlertDialog.popup(app, "Pop Up!", "Expense was added");
              
              guiControl.activateScreen(expenses);
           //guiControl.activateScreen(addExpense);
        }
      }
    };

    addButton.addBehaviour(addButtonBehaviour);

    ///////////////////////////////////////////////
    toggle = new GUIToggle("on", "on.png", white, 0.5)  
    .addState("off", "off.png", white, 0.5)
    .addState("odfsf", "wallet.png", white, 0.5)
    .drawBorder(false)
    .addBehaviour(
      new GUIBehaviour(toggle) {
        public void act(int e) {
          if (e==MOUSEPRESS) {
            //app.addToCollection("Chess",2, 2, 30);
            toggle.previousState();
            println("TESTING TOGGLEEEEEEEEEEEEEEEEEEEE" + toggle.getState());
          }
        }
      }
    )
    ; 
    
    location = new GUILabel("Location")
      .setAlignment(LEFT, CENTER)
      .setLabelColor(black)
      .drawBorder(false)
      .setLabelSize(40)
      .addBehaviour(
      new GUIBehaviour(location) {
        public void act(int e) {
          if (e==MOUSEPRESS) {

            //cam.start();
          }
        }
      }
    )
      ;
    ///////////////////////////////////////////////
    
      backButton = new GUIImage()  
    .setImage("backarrow.png")
    .drawBG(true)
    .setBGColor(blue)
    .addBehaviour(
      new GUIBehaviour(backButton) {
        public void act(int e) {
          if (e==MOUSEPRESS) {
            //app.addToCollection("Chess",2, 2, 30);
            guiControl.activateScreen(expenses);
          }
        }
      }
    )
    ;  
    this
      .setSize(width, height)
      .setPosition(0, 0)
      //.positionElement(accountTF, 1, 2, 10, 1)
      .positionElement(labelTitle, 2, 0, 10, 2)    
      .positionElement(valueTF, 1, 4, 10, 1)
      .positionElement(categoryTF, 1, 6, 10, 1)
      .positionElement(descriptionTF, 1, 8, 10, 1)
      .positionElement(toggle, 9, 10, 2, 2)
      .positionElement(toggleAccounts, 4, 1, 3, 3)
      .positionElement(labelAccount, 4, 1, 6, 3)

      .positionElement(previousAccount, 3, 2, 1, 1)
      .positionElement(nextAccount, 8, 2, 1, 1)
      .positionElement(location, 1, 10, 6, 2)
      .positionElement(addButton, 1, 11, 10, 2)
      .positionElement(backButton, 0, 0, 2, 2)   
      ;
  }
}
