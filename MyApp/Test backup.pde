import java.util.*;

public class Test extends GUIGridLayout {
  
  private GUILabel labelTitle;
  private GUIImage backButton;
  private GUIToggle toggle;
  private GUIChart chart;
  
  Test() {
    super(12, 0.5);
    
      labelTitle = new GUILabel("  Graphs")
      .setAlignment(LEFT, CENTER)
      .setLabelColor(black)
      .drawBG(false)
      .drawBorder(false)
      .setLabelSize(30)
      ;
      
       int[] angles = {90, 90, 180 };
      chart = new GUIChart(angles)
      .activate()
      .drawBG(false);
      
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
    
    
    toggle = new GUIToggle("on", "on.png", white, 0.5)  
    .addState("off", "off.png", white, 0.5)
    .drawBorder(false)
    .addBehaviour(
      new GUIBehaviour(toggle) {
        public void act(int e) {
          if (e==MOUSEPRESS) {
            //app.addToCollection("Chess",2, 2, 30);
            toggle.nextState();
          }
        }
      }
    )
    ;      

   this
      .setSize(width, height)
      .setPosition(0, 0)
      .positionElement(labelTitle, 2, 0, 12, 2)
      .positionElement(backButton, 0, 0, 2, 2)
      .positionElement(chart, 0, 2, 6, 6)
      ;
  }
  
  
/*
//int[] angles; { 30, 10, 45, 35, 60, 38, 75, 67 };
int[] angles;

void pieChart(float diameter, int[] data) {
      double rate = core.totalExpenses();
      System.out.println(rate);
      float lastAngle = 0;
  
  Map<Category, Double> map = core.expensesByCategories();
  
  Set<Category> key = map.keySet();
  angles = new int[key.size()];
  System.out.println(key.size());
  int i=0;
  for(Category category: key){
    int amount = map.get(category).intValue();    
    
    angles[i] = (int)(amount*360)/(int)rate;
    System.out.println(angles[i]);
    float gray = map(i, 0, key.size(), 0, 255);
    fill(gray, 55, 255);
    
    
    arc(width/2, height/2, diameter, diameter, lastAngle, lastAngle+radians(angles[i]));
    lastAngle += radians(angles[i]);
    text(category.getName(), width-width*0.2, height*0.38 + 30*i);    
    i++;
        
  }
  
}
  */
}
