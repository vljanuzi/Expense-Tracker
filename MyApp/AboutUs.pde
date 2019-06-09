public class AboutUs extends GUIGridLayout {
   private GUILabel labelTitle;
   private GUIImage backButton;
   private GUILabel about;

    AboutUs() {
      super(12, 0.5);
      
      
   labelTitle = new GUILabel("About us")
      .setAlignment(LEFT, CENTER)
      .setLabelColor(black)
      .drawBorder(false)
      .setLabelSize(30)
      ;/////////////////////////////////////
     
   
    about = new GUILabel("Money Manager makes managing personal finances as easy as pie! Now easily record your personal and business financial transactions, generate spending reports, review your daily, weekly and monthly financial data and manage your assets with Money Manager's spending tracker and budget planner. Money Manager makes managing personal finances as easy as pie! Now easily record your personal and business financial transactions, generate spending reports, review your daily, weekly and monthly financial data and manage your assets with Money Manager's spending tracker and budget planner. ")
      .setAlignment(LEFT, CENTER)
      .setLabelColor(black)
      .drawBorder(false)
      .setLabelSize(15)
      ;/////////////////////////////////////
     
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
      .positionElement(about, 1, 1, 10, 5)
      .positionElement(backButton, 0, 0, 2, 2)
      ;
    }
    
    
   
}
