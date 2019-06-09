public class AddAccount extends GUIGridLayout {
  //TRANSFER MONEY
  private GUILabel labelTitle;
  private GUITextField textFieldAccountName;
  private GUITextField textFieldAmount;
  private GUIButton addButton;
  private GUIImage backButton;

  AddAccount() {
    super(12, 0.5);

   labelTitle = new GUILabel("Add account")
      .setAlignment(LEFT, CENTER)
      .setLabelColor(black)
      .drawBorder(false)
      .setLabelSize(30)
      ;/////////////////////////////////////
      
      textFieldAccountName = new GUITextField()
      .setPosition(100, 100)
      .setBGColor(white)
      .setBorderColor(color(210, 213, 219))
      .setLabel("Account name: ")
      .setLabelSize(20)
      ;

  GUIBehaviour textFieldAccountNameBehaviour = new GUIBehaviour(textFieldAccountName) {
      public void act(int e) {
        if (e==KEYPRESS) {
          textFieldAccountName.keyRegister(key);
        } else if (e==MOUSEPRESS) {
          KetaiKeyboard.toggle(app);
        }
      }
    };

    textFieldAccountName.addBehaviour(textFieldAccountNameBehaviour);
    String account = textFieldAccountName.read();

    ////////////////////////////////
   textFieldAmount = new GUITextField()
      .setPosition(100, 100)
      .setBGColor(white)
      .setBorderColor(color(210, 213, 219))
      .setLabel("Amount:")
      .setLabelSize(20)
      ;

  GUIBehaviour textFieldAmountBehaviour = new GUIBehaviour(textFieldAmount) {
      public void act(int e) {
        if (e==KEYPRESS) {
          textFieldAmount.keyRegister(key);
        } else if (e==MOUSEPRESS) {
              
          KetaiKeyboard.toggle(app);
        }
      }
    };


    textFieldAmount.addBehaviour(textFieldAmountBehaviour);
    //int textFieldAmount1 = Integer.parseInt(textFieldAmount.read());
            
    addButton = new GUIButton(ANDROID)
    .setLabel("Add account")
    .drawBorder(false)
    .drawBG(true)
    .setBGColor(orange)
    .setLabelColor(white)
    .setLabelSize(30)
    .addBehaviour(
      new GUIBehaviour(addButton) {
        public void act(int e) {
          if (e==MOUSEPRESS) {
            
            String accountName = textFieldAccountName.read();
            int amount = Integer.parseInt(textFieldAmount.read());
            Account account = new Account(accountName, amount);
            
            core.addAccount(account);
            System.out.println(account);

            System.out.println(amount);
            accounts = new Accounts();
            addExpense = new AddExpense();
            KetaiAlertDialog.popup(app, "Congrats!", "Account " + accountName + " has been added");

            guiControl.activateScreen(accounts);

          }
        }
      }
    )
    ; 
    
    
    backButton = new GUIImage()
    .setImage("backarrow.png")
    .addBehaviour(
      new GUIBehaviour(backButton) {
        public void act(int e) {
          if (e==MOUSEPRESS) {
            //app.addToCollection("Chess",2, 2, 30);
            guiControl.activateScreen(mainMenu);
          }
        }
      }
    )
    ; 
    /////////////////////////////////////////
 
    this
      .setSize(width, height)
      .setPosition(0, 0)
      .positionElement(labelTitle, 2, 0, 10, 2)
      .positionElement(textFieldAccountName, 1, 2, 10, 1)
      .positionElement(textFieldAmount, 1, 4, 10, 1)
      .positionElement(backButton, 0, 0, 2, 2)
      .positionElement(addButton, 1, 8, 10, 2)


      ;
  }
}
//////////////////////////////////////////////////////////////////
