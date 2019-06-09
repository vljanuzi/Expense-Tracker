public class TransferMoney extends GUIGridLayout {
  //TRANSFER MONEY
  private GUILabel labelTitle;
  private GUITextField fromAccount;
  private GUITextField toAccount;
  private GUITextField amount;
  private GUIButton button;
  private GUIImage backButton;

  TransferMoney() {
    super(12, 0.5);

   labelTitle = new GUILabel("Transfers")
      .setAlignment(LEFT, CENTER)
      .setLabelColor(black)
      .drawBorder(false)
      .setLabelSize(30)
      ;/////////////////////////////////////
      
      fromAccount = new GUITextField()
      .setPosition(100, 100)
      .setBGColor(white)
      .setBorderColor(color(210, 213, 219))
      .setLabel("From: ")
      .setLabelSize(20)
      ;

  GUIBehaviour fromAccountBehaviour = new GUIBehaviour(fromAccount) {
      public void act(int e) {
        if (e==KEYPRESS) {
          fromAccount.keyRegister(key);
        } else if (e==MOUSEPRESS) {
          KetaiKeyboard.toggle(app);
        }
      }
    };

    fromAccount.addBehaviour(fromAccountBehaviour);
    ///////////////////////////////
    toAccount = new GUITextField()
      .setPosition(100, 100)
      .setBGColor(white)
      .setBorderColor(color(210, 213, 219))
      .setLabel("To: ")
      .setLabelSize(20)
      ;

  GUIBehaviour toAccountBehaviour = new GUIBehaviour(toAccount) {
      public void act(int e) {
        if (e==KEYPRESS) {
          toAccount.keyRegister(key);
        } else if (e==MOUSEPRESS) {
          KetaiKeyboard.toggle(app);
        }
      }
    };

    toAccount.addBehaviour(toAccountBehaviour);
    ////////////////////////////////
   amount = new GUITextField()
      .setPosition(100, 100)
      .setBGColor(white)
      .setBorderColor(color(210, 213, 219))
      .setLabel("Amount:")
      .setLabelSize(20)
      ;

  GUIBehaviour amountBehaviour = new GUIBehaviour(amount) {
      public void act(int e) {
        if (e==KEYPRESS) {
          amount.keyRegister(key);
        } else if (e==MOUSEPRESS) {
          KetaiKeyboard.toggle(app);
        }
      }
    };

    amount.addBehaviour(amountBehaviour);
    
    button = new GUIButton(ANDROID)
    .setLabel("Transfer money")
    .drawBG(true)
    .setBGColor(orange)
    .drawBorder(false)
    .setLabelColor(white)
    .setLabelSize(30)
    .addBehaviour(
      new GUIBehaviour(button) {
        public void act(int e) {
          if (e==MOUSEPRESS) {
            //app.addToCollection("Chess",2, 2, 30);
            String fromAcc = fromAccount.read();
            String toAcc = toAccount.read();
            String value = amount.read();
            Account acc = core.getAccountWithName(fromAcc);
            System.out.println(acc.getAmount());

            core.transferMoney(fromAcc, toAcc, Double.parseDouble(value));
             System.out.println(acc.getAmount());

            KetaiAlertDialog.popup(app, "Pop Up!", "Transfer complete!");
          }
        }
      }
    )
    ; 
    
    
    backButton = new GUIImage()  
    .setImage("backarrow.png")
    .drawBG(true)
    .setBGColor(blue)
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
      .positionElement(fromAccount, 1, 2, 10, 1)
      .positionElement(toAccount, 1, 4, 10, 1)
      .positionElement(amount, 1, 6, 10, 1)
      .positionElement(button, 1, 8, 10, 2)
      .positionElement(backButton, 0, 0, 2, 2)

      ;
  }
}
//////////////////////////////////////////////////////////////////
