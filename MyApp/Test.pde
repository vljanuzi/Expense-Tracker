import java.util.*;
import java.time.LocalDate; // import the LocalDate class

public class Test extends GUIGridLayout {
  
  private GUILabel labelTitle;
  private GUIImage nextMonth;
  private GUIImage previousMonth;
  private GUIToggle toggleMonths;
  private GUIImage backButton;
  private GUIChart chart;
  private GUILabel labelMonth;
  
  Test() {
    super(12, 0.5);

    LocalDate date = LocalDate.now(); // Create a date object
    
    String titleName = " Graphs";
      labelTitle = new GUILabel(titleName)
      .setAlignment(LEFT, CENTER)
      .setLabelColor(black)
      .drawBG(false)
      .drawBorder(false)
      .setLabelSize(30)
      ;
      
      chart = new GUIChart(date.getMonthValue())
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
    
     previousMonth = new GUIImage()  
    .setImage("previousarrow.png")
    .drawBG(true)
    .setBGColor(blue)
    .addBehaviour(
      new GUIBehaviour(previousMonth) {
        public void act(int e) {
          if (e==MOUSEPRESS) {
            toggleMonths.previousState();
          }
        }
      }
    )
    ; 
    
     nextMonth = new GUIImage()  
    .setImage("forwardarrow.png")
    .drawBG(true)
    .setBGColor(blue)
    .addBehaviour(
      new GUIBehaviour(nextMonth) {
        public void act(int e) {
          if (e==MOUSEPRESS) {
            //app.addToCollection("Chess",2, 2, 30);
            toggleMonths.nextState();
            test = new Test();
          }
        }
      }
    )
    ; 
    toggleMonths = new GUIToggle("jan", "jan.png", white, 0.5)
    .addState("feb", "feb.png", white, 0.5)
    .addState("mar", "mar.png", white, 0.5)
    .addState("apr", "apr.png", white, 0.5)
    //.addState("nov", "nov.png", white, 0.5)
    .addState("may", "may.png", white, 0.5)
    .addState("jun", "jun.png", white, 0.5)    
    .addState("jul", "jul.png", white, 0.5)
    .addState("aug", "aug.png", white, 0.5)
    .addState("sep", "sep.png", white, 0.5)
    .addState("oct", "oct.png", white, 0.5)
    .addState("dec", "dec.png", white, 0.5)
    .drawBorder(false)
    .addBehaviour(
      new GUIBehaviour(toggleMonths) {
        public void act(int e) {
          if (e==MOUSEPRESS) {
            //toggle.nextState();
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
      .positionElement(toggleMonths, 4, 1, 3, 3)
      .positionElement(previousMonth, 3, 2, 1, 1)
      .positionElement(nextMonth, 8, 2, 1, 1)
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
