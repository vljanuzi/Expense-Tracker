public class Expenses extends GUIGridLayout {

  private GUILabel labelTitle;
  private GUIImage addButton;
  private GUIImage backButton;
  private ArrayList<GUILabel> labelExpenses;
  private GUITileLayout container;

  Expenses() {
    super(12, 0.5);
    
     labelTitle = new GUILabel("Expenses")
      .setAlignment(LEFT, CENTER)
      .setLabelColor(black)
      .drawBorder(false)
      .setLabelSize(30)
      ;
    /////////////////////////////////////////

     addButton = new GUIImage()
     .setImage("plus.png")
     .setAlignment(LEFT, BOTTOM)
     .addBehaviour(
       
      new GUIBehaviour(addButton) {
           public void act(int e) {
             if (e==MOUSEPRESS) {  
               guiControl.activateScreen(addExpense);
             }else if (e==KEYPRESS){        
             }
           }
         }
     )
     ;

    /////////////////////////////////////////
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

    container = new GUITileLayout();
    labelExpenses = new ArrayList<GUILabel>();
    System.out.println(core.getAccount(0).getNumberOfExpenses() + "sdlk;fjgsdf;sdjlfdsfdsf");
    int k = 0;
    
    for (int i = 0; i < core.sizeOfAccounts(); i++) {

      for (int j = 0; j < core.getAccount(i).getNumberOfExpenses(); j++) {

        labelExpenses.add(new GUILabel(core.getAccount(i).getName() + "\n" + core.getAccount(i).getExpense(j).getDescription() + " $" + core.getAccount(i).getExpense(j).getPrice()));
        labelExpenses.get(k)
        .setAlignment(TOP, LEFT)
        .setAlignment(CENTER, CENTER)
        .setLabelColor(white)
        .drawBG(true)
        .setBGColor(orange)
        ;
        container.add(labelExpenses.get(k)); 
        k++;

      }

  }
  
  container.arrangeByRowsAndCols(10, 1, 490, 1000,  0.2)
  .addBehaviour(
    new GUIBehaviour(this) {
    public void act(int e) {
      if (e==MOUSEDRAG) {
        owner.setPosition(1000,1000);
          //owner.setPosition(int(confine(width-owner.getWidth(), owner.getX()+(mouseY-pmouseY), 0)), owner.getY());
          print("Height: " + height + " w: " + owner.getHeight());
      } else if (e==DOUBLETAP) {
        guiControl.activateScreen(mainMenu);
      }
    }  
    private float confine(float min, float value, float max) {
        if (min >=value) return min;
        else if (max <= value) return max;
        else return value;
    }

   } 
  );

  
  container
  .drawBorder(false)
  .drawBG(false);
/////////////////////////////////////////
 
    this
      .setSize(width, height)
      .setPosition(0, 0)
      .positionElement(labelTitle, 2, 0, 12, 2)
      .positionElement(addButton, 9, 11, 2, 2)
      .positionElement(backButton, 0, 0, 2, 2)
      .positionElement(container, 0, 2, 10, 12)
      ;
      //container.arrangeByRowsAndCols(10, 1, 490, 1000,  0.2);
  }
}
