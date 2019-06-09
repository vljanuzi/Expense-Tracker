public class MainMenu extends GUIGridLayout {
  //MAIN MENU
  private GUILabel labelTitle;
  private GUILabel labelAccounts;
  private GUILabel labelExpenses;
  private GUILabel labelTransfers;
  private GUILabel labelPieChart;
  private GUILabel labelAboutUs;


  private GUIImage imageAccounts;
  private GUIImage imageExpenses;
  private GUIImage imageTransfers;
  private GUIImage imagePieChart;
  private GUIImage imageAboutUs;

  private GUIButton button2;

  MainMenu() {
    super(12, 0.5);

    labelTitle = new GUILabel("   Expense Tracker")
      .setAlignment(LEFT, CENTER)
      .setLabelColor(white)
      .drawBG(true)
      .setBGColor(orange)
      .drawBorder(false)
      .setLabelSize(30)
      ;
      
     /////////////////////////////////////////

      imageAccounts = new GUIImage()
     .setImage("accounts.png")
     .setAlignment(LEFT, TOP)
     .addBehaviour(
       
         new GUIBehaviour(imageAccounts) {
           public void act(int e) {
             if (e==MOUSEPRESS) { 
               //guiControl.activateScreen(addAccount);
             }else if (e==KEYPRESS){        
             }
           }
         }
     )
     ;
     
    labelAccounts = new GUILabel("Accounts")
      .setAlignment(LEFT, CENTER)
      .setLabelColor(black)
      .drawBG(false)
      .drawBorder(false)
      .setLabelSize(30)
      .addBehaviour(
        new GUIBehaviour(labelAccounts) {
          public void act(int e) {
            if (e==MOUSEPRESS) {
              guiControl.activateScreen(accounts);
            }
          }
        }
      )
      ;
          
    /////////////////////////////////////////
    
   imageExpenses = new GUIImage()
     .setImage("expenses.png")
     .setAlignment(LEFT, TOP)
     .setSize(20, 20)       
     .addBehaviour(
       
      new GUIBehaviour(imageExpenses) {
           public void act(int e) {
             if (e==MOUSEPRESS) {       
             }else if (e==KEYPRESS){        
             }
           }
         }
     )
     ;
     
       labelExpenses = new GUILabel("Expenses")
      .setAlignment(LEFT, CENTER)
      .setLabelColor(black)
      .drawBG(false)
      .drawBorder(false)
      .setLabelSize(30)
      .addBehaviour(
        new GUIBehaviour(labelExpenses) {
          public void act(int e) {
            if (e==MOUSEPRESS) {
              guiControl.activateScreen(expenses);
            }
          }
        }
      )
      ;
      
      //////////////////////////
        labelTransfers = new GUILabel("Transfers")
      .setAlignment(LEFT, CENTER)
      .setLabelColor(black)
      .drawBG(false)
      .drawBorder(false)
      .setLabelSize(30)
      .addBehaviour(
       new GUIBehaviour(imageTransfers) {
           public void act(int e) {
             if (e==MOUSEPRESS) { 
               guiControl.activateScreen(transferMoney);
             }else if (e==KEYPRESS){        
             }
           }
         }
     )
      ;
      
      imageTransfers = new GUIImage()
     .setImage("transfers.png")
     .setAlignment(LEFT, TOP)
     .addBehaviour(
       
         new GUIBehaviour(imageTransfers) {
           public void act(int e) {
             if (e==MOUSEPRESS) { 
             }else if (e==KEYPRESS){        
             }
           }
         }
     )
     ;
     
      /////////////////////////////////////////
   labelPieChart = new GUILabel("Graphs")
      .setAlignment(LEFT, CENTER)
      .setLabelColor(black)
      .drawBG(false)
      .drawBorder(false)
      .setLabelSize(30)
      .addBehaviour(
       new GUIBehaviour(imagePieChart) {
           public void act(int e) {
             if (e==MOUSEPRESS) { 
               guiControl.activateScreen(test);
             }else if (e==KEYPRESS){        
             }
           }
         }
     )
      ;
      
      imagePieChart = new GUIImage()
     .setImage("pie-chart.png")
     .setAlignment(LEFT, TOP)
     .addBehaviour(
       
         new GUIBehaviour(imagePieChart) {
           public void act(int e) {
             if (e==MOUSEPRESS) { 
             }else if (e==KEYPRESS){        
             }
           }
         }
     )
     ;
///////////////////////////////////

     imageAboutUs = new GUIImage()
     .setImage("information.png")
     .setAlignment(LEFT, TOP)
     .setSize(20, 20)       
     .addBehaviour(
       
      new GUIBehaviour(imageAboutUs) {
           public void act(int e) {
             if (e==MOUSEPRESS) {       
             }else if (e==KEYPRESS){        
             }
           }
         }
     )
     ;
     
       labelAboutUs = new GUILabel("About us")
      .setAlignment(LEFT, CENTER)
      .setLabelColor(black)
      .drawBG(false)
      .drawBorder(false)
      .setLabelSize(30)
      .addBehaviour(
        new GUIBehaviour(labelAboutUs) {
          public void act(int e) {
            if (e==MOUSEPRESS) {
              guiControl.activateScreen(aboutUs);
            }
          }
        }
      )
      ;
      
    this
      .setSize(width, height)
      .setPosition(0, 0)
      .positionElement(labelTitle, 0, 0, 12, 2)
      .positionElement(imageAccounts, 1, 2, 2, 2)
      .positionElement(labelAccounts, 4, 2, 8, 2)
      .positionElement(imageExpenses, 1, 4, 2, 2)
      .positionElement(labelExpenses, 4, 4, 8, 2)
      .positionElement(labelTransfers, 4, 6, 8, 2)
      .positionElement(imageTransfers, 1, 6, 2, 2)  
      .positionElement(labelPieChart, 4, 8, 8, 2)
      .positionElement(imagePieChart, 1, 8, 2, 2)  
      .positionElement(labelAboutUs, 4, 10, 8, 2)
      .positionElement(imageAboutUs, 1, 10, 2, 2)


      ;
  }
}
//////////////////////////////////////////////////////////////////
