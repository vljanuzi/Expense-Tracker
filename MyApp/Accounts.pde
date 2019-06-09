public class Accounts extends GUIGridLayout {
private GUILabel labelTitle;
private GUIImage backButton;
private GUIImage addButton;
private ArrayList<GUILabel> labelAccounts;
private GUITileLayout container;



    

  Accounts() {
    super(12, 0.5);

  
  
  labelTitle = new GUILabel("Accounts")
      .setAlignment(LEFT, CENTER)
      .setLabelColor(black)
      .drawBorder(false)
      .setLabelSize(30)
      ;
      
   addButton = new GUIImage()
     .setImage("plus.png")
     .setAlignment(LEFT, BOTTOM)
     .addBehaviour(
       
      new GUIBehaviour(addButton) {
           public void act(int e) {
             if (e==MOUSEPRESS) {  
               guiControl.activateScreen(addAccount);
             }else if (e==KEYPRESS){        
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
            //app.addTolabelAccountsion("Chess",2, 2, 30);
            guiControl.activateScreen(mainMenu);
          }
        }
      }
    )
    ; 
    
    /////////////////////////////////////////
  container = new GUITileLayout();
  labelAccounts = new ArrayList<GUILabel>();
   
 

  for (int i = 0; i < core.sizeOfAccounts(); i++) {
    labelAccounts.add(new GUILabel(core.getAccount(i).getName() + " " + "$" + core.getAccount(i).getAmount()));
    
    labelAccounts.get(i)
    .setAlignment(CENTER, CENTER)
    .setLabelColor(white)
    .drawBG(true)
    .setBGColor(orange)
    .addBehaviour(
      new GUIBehaviour(labelAccounts.get(i)) {
        public void act(int e) {
          if (e==MOUSEPRESS) {
             guiControl.activateScreen(editAccount);
          }
        }
      }
    )
    ;
    container.add(labelAccounts.get(i));
    
  }
  
  container
  .drawBorder(false)
  .drawBG(false);
    
  this
      .setSize(width, height)
      .setPosition(0, 0)
      .positionElement(labelTitle, 2, 0, 12, 2)
      .positionElement(addButton, 9, 11, 2, 2)
      .positionElement(backButton, 0, 0, 2, 2)
      .positionElement(container, 0, 2, 10, 12)
      ;
      container.arrangeByRowsAndCols(10, 1, 490, 1000,  0.2);


  } 
}
