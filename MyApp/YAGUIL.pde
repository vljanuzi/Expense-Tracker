///////////////////////////////////////////////////////////////////////////
////////////////DO NOT CHANGE THE CODE BELLOW THIS POINT///////////////////
///////////////////////////////////////////////////////////////////////////

/** 
* An abstract class used to define the behaviour of GUI elemements
* possible events:
* <ul>
* <li>MOUSEPRESS, for PC apps</li>
* <li>MOUSERELEASE, for PC apps</li>
* <li>MOUSEDRAG, for PC apps</li>
* <li>KEYPRESS, for PC and ANDROID apps</li>
* <li>KEYRELEASE, for PC and ANDROID apps</li>
* <li>TAP, for ANDROID apps</li>
* <li>DOUBLETAP, for ANDROID apps</li>
* <li>LONGPRESS, for ANDROID apps</li>
* <li>PINCH, for ANDROID apps</li>
* <li>ROTATE, for ANDROID apps</li> 
* </ul>
* @author Kostas Dimopoulos
*/

public static final int MOUSEPRESS = 0;
public static final int MOUSERELEASE = 1;
public static final int MOUSEDRAG = 2;
public static final int KEYPRESS = 3;
public static final int KEYRELEASE = 4;
public static final int TAP = 5;
public static final int DOUBLETAP = 6;
public static final int LONGPRESS = 7;
public static final int PINCH = 8;
public static final int ROTATE = 9;

public abstract class GUIBehaviour{
  
  protected GUIElement owner;

/**
* Condtructor
* @param e the element that is the owner of the behaviour
*/
  GUIBehaviour(GUIElement e){
    owner = e;
    if(owner !=null)
      owner.addBehaviour(this);
  }
/**
* Abstact method that defines what the behaviour of the element should be
* @param et the event type identified 
*/
  public abstract void act(int et);
}
////////////////////PIE CHART//////////////////////////

public class GUIChart extends GUIElement<GUIChart> {
    int month;
     GUIChart(int month) {
       super();
        this.month = month;
       //pieChart(size);
     }
     void draw() {

     pieChart(300,month);
  }



  void pieChart(float diameter,int month) {
        double rate = core.totalExpenses();
        System.out.println(rate);
        float lastAngle = 0;
    
        Map<Category, Double> map = core.expensesByCategories(month);
      
        Set<Category> key = map.keySet();
        int[] angles = new int[key.size()];
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
}

//////////////////////////////////////////////////////////////////
/**
* A pressable button. Can be for ANDROID or PC applications. In ANDROID there is no highlight.
* The default element label is used as button text. Alternatively it can have an icong instead of text
* @author Kostas Dimopoulos
*/


public static final int ANDROID = 0;
public static final int PC = 1;

public class GUIButton extends GUIElement <GUIButton> {
  private PImage pic;
  private color PressedColor;
  private color HighlightColor;
  private int mode;
/**
* Default constructor
* @param mode defines if it is in ANDROID mode or PC (use ANDROID or PC values)
*/

  GUIButton(int mode) {
    super();
    pic= null;
    PressedColor = BGcolor;
    HighlightColor = BGcolor;
    this.mode = mode;
    drawLabel = false;
  }
/**
* Non default constructor
* To be used if no layout is used. 
* @see GUIGridLayout 
* @see GUITileLayout
* @param l the of the element. unless otherwise defined, it is drawn right above the top left corner of the element
* @param x the x position of the top left corner of the element. Usually determined by the GUIcontainer the element is placed in automatically
* @param y the y position of the top left corner of the element. Usually determined by the GUIcontainer the element is placed in automatically
* @param w the width of the element. Usually determined by the GUIcontainer the element is placed in automatically
* @param h the height of the element. Usually determined by the GUIcontainer the element is placed in automatically
* @param m defines if it is in ANDROID mode or PC (use ANDROID or PC values)
*/
  GUIButton(String l, int x, int y, float w, float h, int m) {
    super(l, x, y, w, h);
    pic= null;
    PressedColor = BGcolor;
    HighlightColor = BGcolor;
    mode = m;
    drawLabel = false;
  }

/**
* Set the color when the button is pressed
*/
  GUIButton setPressedColor(color c) {
    PressedColor = c;
    return this;
  }
/**
* Set the color when the button is highlighted (Moues hover, only on PC mode)
*/
  GUIButton setHighlightColor(color c) {
    HighlightColor = c;
    return this;
  }  
  
/**
* Sets an image instead of the text
* @param path the path of the image to be shown instead of text (the label). All images should be in a subfolder "data". 
* The path does not include the "data" folder
*/
  GUIButton setImage(String path) {
    pic = loadImage(path);
    return this;
  }

  void draw() {
    if (isActive) {
      if (mode == PC) {
        if (hasFocus()&&!mousePressed) {
          rectMode(CORNER);
          stroke(borderColor);      
          fill(HighlightColor);
          rect(_x-5, _y-5, _w+10, _h+10);
        } else if (hasFocus() && mousePressed) {
          rectMode(CORNER);
          stroke(borderColor);
          fill(PressedColor);
          rect(_x+5, _y+5, _w-10, _h-10);
        } else { 
          super.draw();
        }
      } else if (mode == ANDROID) {
        if (hasFocus() && mousePressed) {
          rectMode(CORNER);
          stroke(borderColor);
          fill(PressedColor);
          rect(_x+5, _y+5, _w-10, _h-10);
        } else { 
          super.draw();
        }
      }
      if (pic !=null) {
        pic.resize(int(_w), int(_h));
        image(pic, _x, _y);
      } else {
        fill(LBLcolor);
        textSize(LBLsize);
        rectMode(CORNER);
        textAlign(CENTER, CENTER);
        text(label, _x, _y, _w, _h);
      }
    }
  }
}
//////////////////////////////////////////////////////////////////
/** A GUIContainer is an unstructure container of GUI elements. 
*As the GUIContainer is a GUIElement it can be nested within other GUIContainers
*GUIContainers can be activated or deactivated, meaning that the GUIElements it
*contains are also activated or deactivated.
*A deactivated GUIElement is not drawn, nor it can be interacted with.
*When A GUIContainer recieves an alert from the GUIController, it alerts
*its GUIElements to act their behaviours
* @author Kostas Dimopoulos
*/
public class GUIContainer<T extends GUIContainer<T>> extends GUIElement<T> {
  protected ArrayList<GUIElement> collection;
  protected T me;

  GUIContainer() {
    super();
    collection = new ArrayList<GUIElement>();   
    drawBorder = drawBG = drawLabel = false;
    me = (T) this;
  }

/**
* @param c a premade array list of elements
*/
  GUIContainer(ArrayList<GUIElement> c) {
    super();
    collection = c;   
    drawBorder = drawBG = drawLabel = false;
    me = (T) this;
  }

  ArrayList<GUIElement> getCollection() {
    return collection;
  }

  T add(GUIElement e) {
    collection.add(e);
    return me;
  }

  T remove(GUIElement e) {
    collection.remove(e);
    return me;
  }
/**
* Makes all elements in the collection visible and interactable
*/
  T activate() {
    isActive = true;
    for (int i=0; i<collection.size(); i++) {
      collection.get(i).activate();
    }
    return me;
  }  

/**
* Makes all elements in the collection invisible and not interactable
*/
  T deactivate() {
    isActive = false;
    for (int i=0; i<collection.size(); i++) {
      collection.get(i).deactivate();
    }
    return me;
  }

/**
* Alerts all elements contained about an event / gesture
* @param et the gesture / event type that the element responds to. See the list at class description
*/
  void alert(int et) {
    //print("Alert pickedup by "+this.getClass().getName());
    if(this.hasFocus()) {
      behave(et);
    }
    for (int i=0; i<collection.size(); i++) {
      if (collection.get(i) instanceof GUIContainer) {
        GUIContainer temp = (GUIContainer) collection.get(i);
        temp.alert(et);
      } else {
        if (collection.get(i).hasFocus()) {
          collection.get(i).behave(et);
        }
      }
    }
  }
}
//////////////////////////////////////////////////////////////////
/** Main driving engine. It acts a a finite state machine activating 
*"screens" of the application. Screens can be any type of GUIContainer.
*For making the code clearer. Define each screen in a seperate file.
*See ScreenTemplate.pde
* @author Kostas Dimopoulos
*/
public class GUIController {
  private ArrayList<GUIContainer> screens;
  
  private GUIContainer activeScreen;

  GUIController() {
    screens = new  ArrayList<GUIContainer>();
    activeScreen = null;
  }

  GUIController addScreen(GUIContainer c) {
    screens.add(c);
    return this;
  }

  GUIController removeScreen(GUIContainer c) {
    screens.remove(c);
    return this;
  }

  GUIController activateScreen(GUIContainer c) {
    if (activeScreen !=null) {
      activeScreen.deactivate();
    }
    activeScreen = c;
    activeScreen.activate();
    return this;
  }

  void alert(int eventType) {
    activeScreen.alert(eventType);
  }

  void draw() {
    activeScreen.draw();
  }
}
//////////////////////////////////////////////////////////////////
/**
* The basic GUIElement. All other elements inherite this class.
* @author Kostas Dimopoulos
*/

public class GUIElement<T extends GUIElement<T>> {
  protected float _w, _h;
  protected int _x, _y;
  protected String label;
  protected int LBLsize;
  protected color borderColor;
  protected color BGcolor;
  protected color LBLcolor;
  protected boolean drawBorder, drawBG, drawLabel;
  protected T me;
  protected boolean isActive;
  protected GUIBehaviour behaviour;
/**
* Default constructor
*/
  GUIElement() {
    _x = 0;
    _y = 0;    
    _w = 20;
    _h = 20;
    label = "";
    LBLsize = int(_h/2);
    borderColor = color(0, 0, 0);
    BGcolor = color(26, 82, 118);
    LBLcolor = color(0, 0, 0);
    drawBorder = drawBG = drawLabel = true;
    me = (T) this;
    isActive = false;
    behaviour=null;
  }
/**
* Non default constructor
* @param l the of the element. unless otherwise defined, it is drawn right above the top left corner of the element
* @param x the x position of the top left corner of the element. Usually determined by the GUIcontainer the element is placed in automatically
* @param y the y position of the top left corner of the element. Usually determined by the GUIcontainer the element is placed in automatically
* @param w the width of the element. Usually determined by the GUIcontainer the element is placed in automatically
* @param h the height of the element. Usually determined by the GUIcontainer the element is placed in automatically
*/
  GUIElement(String l, int x, int y, float w, float h) {
    _x = x;
    _y = y;    
    _w = w;
    _h = h;
    label = l;
    LBLsize = int(_h/2);
    borderColor = color(0, 0, 0);
    BGcolor = color(26, 82, 118);
    me = (T) this;
    behaviour=null;
  }
/**
* Makes the element drawable and interactable.
*/
  T activate() {
    isActive = true;
    return me;
  }
/**
* Makes the element invisible and non interactable.
*/  
  T deactivate() {
    isActive = false;
    return me;
  }
/**
* Sets the size of the element. Usually called by the Layout the element register to
* @param w the width in pixels
* @param h the height in pixels
* @see GUIGridLayout
* @see GUITileLayout
*/
  T setSize(float w, float h) {
    _w = w;
    _h = h;
    return me;
  }
/**
* Sets the lable of the element. In all elements except buttons, labels and toggles
* the lable is written at the top left above the element
*/
  T setLabel(String l) {
    label = l;
    return me;
  }
/**
* Sets the position of the element. Usually called by the Layout the element register to
* @param x the x position in pixels
* @param y the y position in pixels
* @see GUIGridLayout
* @see GUITileLayout
*/
  T setPosition(int x, int y) {
    _x = x;
    _y = y;
    return me;
  }
/**
* Sets the background color of the element
*/
  T setBGColor(color c) {
    BGcolor = c;
    return me;
  } 
/**
* Sets the color of the border of the element
*/
  T setBorderColor(color c) {
    borderColor = c;
    return me;
  }
/**
* Sets the text color of the label of the element
*/
  T setLabelColor(color c) {
    LBLcolor = c;
    return me;
  }
/**
* Sets the size of the text of the label of the element
*/
  T setLabelSize(int s) {
    LBLsize = s;
    return me;
  }

  T drawBorder(boolean value) {
    drawBorder = value;
    return me;
  }

  T drawBG(boolean value) {
    drawBG = value; 
    return me;
  }

  T drawLabel(boolean value) {
    drawLabel = value; 
    return me;
  }
/**
* Adds the element to a GUIConteiner. This may result to resizing and repositining the element
*/
  T addToGroup(GUIContainer c){
    c.add(me);
    return me;
  }
  
  T removeFromGroup(GUIContainer c){
    c.remove(me);
    return me;
  }

  int getY() {
    return _y;
  }

  int getX() {
    return _x;
  }  

  float getWidth() {
    return _w;
  } 

  float getHeight() {
    return _h;
  } 
/**
* Adds a behaviour to the element
* @see GUIBehaviour
*/
  T addBehaviour(GUIBehaviour b){
    behaviour=b;  
    return me;
  }
/**
* Force the element to act its GUI behaviour (if it has one)
* @param et the gesture / event type that the element responds to. See the list at class description
*/
  void behave(int et){
    if(behaviour != null){
      //print("behave method called by "+this.getClass().getName());
      behaviour.act(et);    
    }
  }

  void draw() {
    if (isActive) {
      rectMode(CORNER);
      if (drawBorder) stroke(borderColor);
      else noStroke();
      if (drawBG) fill(BGcolor); 
      else noFill();
      rect(_x, _y, _w, _h);
      if (drawLabel) {
        rectMode(CORNER);
        fill(LBLcolor);
        textSize(LBLsize);
        textAlign(LEFT);
        text(label, _x, _y);
      }
    }
  }

  boolean hasFocus() {
    if (mouseY >=_y && mouseY <= _y+_h && mouseX >= _x && mouseX <=_x+_w && isActive) return true;
    else return false;
  }
  
  String toString(){
    return this.getClass().getName();  
  }
}
//////////////////////////////////////////////////////////////////
/**
* <p>The GUIGridLayout is a GUIContainer that may structure its elements in a grid, following similar principles as 
* Bootstrap. The constractor requires to know 2 things:</p>
* <ol>
* <li>how many horizontal pieces a row has. Basically breaks the width of the conatiner to that many squares</li> 
* <li>how much ratio of the squares side to use as disctance between rows.</li> 
* </ol>
* <p>As the GUIGridLayout inherits from the GUIElement it can be nested in other layouts</p>
* <p>Example: A screen of 400x600 (width x height), is broken down to row with each row made of 12 squares.
* 400/12 = 33.333. So each square has a side of 33 pixels, with 2 pixels left and 2 right margins (12*33 + 4 = 400)
* We can define a percentage of that square side to be a distance between rows,
* with a ratio of 0.5 each row from the next will be 16 pixels apart.
* When an element is positioned, we define the row and column as well as how many square it shoud span
* horizontally and verically. We count from 0</p>
* <p>Example 1: to add an element e to the grid and place it across all the 1st row, use positionElement(e,0,0,12,1)
* The first 0 is the 0th row, the secod 0 is the first cell of that row, the 12 is the horizontal span (12 squares), and the 1 
* is the vertical span</p> 
* <p>
* Example 2: three elements side by side on 2nd row, with no space between them:<br>
* positionElement(e1, 0,1,4,1)<br>
* positionElement(e2, 4,1,4,1)<br>
* positionElement(e3, 8,1,4,1)</p>
*/

public class GUIGridLayout extends GUIContainer <GUIGridLayout> {
  private int gridPieces;
  private int gridSize; //pixels per column
  private ArrayList<GridInfo> gf;
  private int rowspace;
  private int sideborder;
  private boolean drawGrid;
  private color gridColor;
/**
* Creates a grid layout using all availabe width and height
* @param c the number of cells or squares in each row
* @param dpc the distance percentage between rows. A % of the calculated square size. 0<=dpc<=1
*/
  GUIGridLayout(int c, float dpc) {    
    super();
    gridPieces = c;
    _w = width;
    _h = height;
    gridSize = int(_w / gridPieces);
    gf = new ArrayList<GridInfo>();
    collection = new ArrayList<GUIElement>();
    drawBorder = drawBG = drawLabel = false;  
    rowspace = int(gridSize*dpc);
    sideborder = (int(_w)%gridPieces)/2;
    drawGrid = false;
    gridColor = color(0,0,0);
  }
/**
* Creates a grid layout
* @param c the number of cells or squares in each row
* @param dpc the distance percentage between rows. A % of the calculated square size. 0<=dpc<=1
* @param w the width of the Grid
* @param h the height og the Grid
*/ 
   GUIGridLayout(int c, float dpc, float w, float h) {    
    super();
    gridPieces = c;
    _w = w;
    _h = h;
    gridSize = int(_w / gridPieces);
    gf = new ArrayList<GridInfo>();
    collection = new ArrayList<GUIElement>();
    drawBorder = drawBG = drawLabel = false;  
    rowspace = int(gridSize*dpc);
    sideborder = (int(_w)%gridPieces)/2;
    drawGrid = false;
  } 
/**
* Adds an element to the collection and places it to the grid
* @param x the row to be placed. Not to be confused with position of the element in pixels
* @param y the column to be placed. Not to be confused with position of the element in pixels
* @param spanx how many cells in the row it will span
* @param spanx how many cells in the columns (incl the space between them) it will span
*/
  GUIGridLayout positionElement(GUIElement e, int x, int y, int spanx, int spany) {
    if(!collection.contains(e)){
      super.add(e);
    }
    if (x>=0 && x<gridSize && y>=0) {
      gf.add(new GridInfo(x, y, spanx, spany));
      e.setPosition(sideborder+x*gridSize, y*(gridSize+rowspace))
       .setSize(spanx*gridSize, spany*gridSize+(spany-1)*rowspace)
       ;
    }
    return this;
  }
  
  GUIGridLayout remove(GUIElement e){
    int i = collection.indexOf(e);
    if(i>-1){
      super.remove(e);
      gf.remove(i);
    }
    return this;
  }

  GUIGridLayout refreshElement(int index) {
    collection
      .get(index)
      .setPosition(sideborder+gf.get(index).getColumn()*(gridSize+rowspace), gf.get(index).getRow()*gridSize)
      .setSize(float(gf.get(index).getColumnSpan()*gridSize), float(gf.get(index).getRowSpan()*gridSize))
      ; 
    return this;
  }

  GUIGridLayout moveElement(int index, int newC, int newR) {
    if (index < collection.size()) {
      gf
        .get(index)
        .placeAt(newC, newR)
        ;
      refreshElement(index);
    }
    return this;
  }

  GUIGridLayout resizeElement(int index, int newCspan, int newRspan) {
    if (index < collection.size()) {
      gf
        .get(index)
        .occupySpace(newCspan, newRspan)
        ;
      refreshElement(index);
    }
    return this;
  }
/**
* Draws the gird lines to help see the positions of elements. Use it to beter design
*/
  GUIGridLayout showGridLines(boolean b){
    drawGrid = b;
    return this;  
  }
 /**
 * Define the color of the grid lines
 * @see GUIGridLayout#showGridLines
 */
  GUIGridLayout setGridLineColor(color c){
    gridColor = c;
    return this; 
  }

  void draw() {
    if (isActive) {
      for (int i=0; i<collection.size(); i++) {
        collection.get(i).draw();
      }
      if(drawGrid){
        stroke(gridColor);
        fill(200,100);
        for(int i=0; i<=gridPieces; i++){
          for(int point=0; point<_h; point+=gridSize+rowspace){
            rect(sideborder+i*gridSize, point, gridSize, gridSize);
          }
        }
      }
    }
  }
}

private class GridInfo {
  private int col, row, colspan, rowspan;

  GridInfo(int a, int b, int c, int d) {
    col = a;
    row = b;
    colspan = c;
    rowspan = d;
  }

  GridInfo placeAt(int a, int b) {
    col = a;
    row = b;
    return this;
  }

  GridInfo occupySpace(int c, int d) {
    colspan = c;
    rowspan = d;
    return this;
  }

  int getColumn() {
    return col;
  }

  int getRow() {
    return row;
  }

  int getColumnSpan() {
    return colspan;
  }

  int getRowSpan() {
    return rowspan;
  }
}
//////////////////////////////////////////////////////////////////
/** An image.
*/

public class GUIImage extends GUIElement <GUIImage> {
  private PImage pic;
  private int hAlignment;
  private int vAlignment;  

  GUIImage() {
    super();
    pic= null;
    drawLabel = false;
    hAlignment = CENTER;
    vAlignment = CENTER;
  }

  GUIImage(String imagePath, int x, int y, float w, float h) {
    super("", x, y, w, h);
    pic= loadImage(imagePath);
    drawLabel = false;
    hAlignment = CENTER;
    vAlignment = CENTER;
  }

  GUIImage setImage(String imagePath) {
    pic = loadImage(imagePath);
    return this;
  }
  
/**
* sets the horizontal alaignment to LEFT, RIGHT or CENTER 
* and the vertical alaingment to TOP, CENTER, BOTTOM
*/
  GUIImage setAlignment(int horizontal, int vertical) {
    hAlignment = horizontal;
    vAlignment = vertical;
    return this;
  }

  void draw() {
    if (isActive) {
      if (pic !=null) {
        pic.resize(int(_w), int(_h));
        image(pic, _x, _y);
      } else {
        fill(LBLcolor);
        textSize(LBLsize);
        rectMode(CORNER);
        textAlign(hAlignment, vAlignment);
        text("No Image", _x, _y, _w, _h);
      }
    }
  }
}
//////////////////////////////////////////////////////////////////
/**
* Draws the label of the element as text inside the element dimensions overwrighting the default way
*/

public class GUILabel extends GUIElement<GUILabel> {

  private int hAlignment;
  private int vAlignment;

/**
* Default constructor
*/
  GUILabel() {
    super();
    drawBorder = drawBG = drawLabel = false;
    hAlignment = CENTER;
    vAlignment = CENTER;
    LBLsize = int(_h/1.2);
  }
/**
* Non default constructor
* @param l the text to be written
*/
  GUILabel(String l) {
    super();
    label = l;
    drawBorder = drawBG = drawLabel = false;
    hAlignment = CENTER;
    vAlignment = CENTER;
    LBLsize = int(_h/1.2);
  }
  
/**
* sets the horizontal alaignment to LEFT, RIGHT or CENTER 
* and the vertical alaingment to TOP, CENTER, BOTTOM
*/
  GUILabel setAlignment(int horizontal, int vertical) {
    hAlignment = horizontal;
    vAlignment = vertical;
    return this;
  }

  GUILabel setLabel(String l) {
    label = l;
    return this;
  }

  void draw() {
    if (isActive) {
      super.draw();
      rectMode(CORNER);
      fill(LBLcolor);
      textSize(LBLsize);
      textAlign(hAlignment, vAlignment);
      text(label, _x, _y, _w, _h);
    }
    
  }
}
//////////////////////////////////////////////////////////////////
/**
* A textfield of a single line used for writing using the Keyboard.
* Can only be used inn ANDROID mode
*/

public class GUITextField extends GUIElement<GUITextField> {
  private String text;
  private String textToShow;
  private int index;

/**
* Default constructor
*/
  GUITextField() {
    super();
    text = "";
    textToShow = "";
    index = 0;
    drawBG = false;
  }

/**
* reads a key press
*/
  void keyRegister(int keycode) {
    if (keycode == 65535) {
      deleteChar();
    } else if (keycode == 10) { //user pressed return
      KetaiKeyboard.toggle(app); //TODO fix it to be java compliant
    } else {
      println(int(key));
      writeChar(char(keycode));
    }
  }

  private void deleteChar() {
    if (text.length()>0) {
      text = text.substring(0, text.length()-1);
      if (index ==0) {
        textToShow = text;
      } else {
        index--;
        textToShow = text.substring(index);
      }
    }
  }

  private void writeChar(char c) {

    text = text+c;
    if (textWidth(text)<= _w) {
      textToShow = text;
    } else {
      index++;
      textToShow = text.substring(index);
    }
  }

  void clear() {
    text = "";
    textToShow = "";
  }

/**
* @return the string written in the textfield
*/
  String read() {
    return text;
  }

  void draw() {
    if (isActive) {
      super.draw();
      textAlign(LEFT, CENTER);
      textSize(_h/2);
      text(textToShow, _x+3, _y, _w, _h);
    }
  }
}
//////////////////////////////////////////////////////////////////
/**
 * A GUIContainer designed for albums. 
 * Elements here are placed as tiles (squares), organised in rows and columns
 */

public class GUITileLayout extends GUIContainer <GUITileLayout> {
  private int rows;             //the number of rows of tiles 
  private int cols;             //the number of colunms of tiles 
  private int colspace;         //the number of pixels between columns (incl distance from walls)
  private int rowspace;         //the number of pixels between rows (incl distance from walls)
  private int itemWidth;        //the width of each tile in pixels
  private int itemHeight;       //the height of each tile in pixels
  private float DPC;            /*Distance PerCent precentage of width and hight used for space between cols and rows
                                  ex 0.1 is 10% of the width used for all space left between cols*/

  GUITileLayout() {    
    super();
    rows = 1;
    cols = 1;
    DPC = 0.1; //10%
    colspace = int(_w*DPC/(cols+1));
    rowspace = int(_h*DPC/(rows+1));
  }
/**
* Arranges the tiles in rows and columns specified within a specified width and height.
* This forces the size of the elements
* @param r how many rows
* @param c how many columns
* @param w the width in pixels
* @param h the height in pixels
* @param dpc Distance PerCent % of width and height used for space between cols and rows. 0% 0<dpc<=1 100%                                  
*/
  GUITileLayout arrangeByRowsAndCols(int r, int c, float w, float h, float dpc) {
    if (r*c*w*h>0) {
      rows = r;
      cols = c;
      _w = w; 
      _h = h; 
      if(dpc>=0 && dpc<=1) DPC = dpc;
      else DPC = 0.1;
      colspace = int(_w*DPC/(cols+1));
      rowspace = int(_h*DPC/(rows+1));
      itemWidth = int((_w-(cols+1)*colspace)/cols);
      itemHeight = int((_h-(rows+1)*rowspace)/rows);
      //println("rows: "+rows+" cols: "+cols+" w: "+w+" h: "+h+" colspace: "+colspace+" rowspace: "+rowspace+" itemWidth: "+itemWidth+" itemHeight: "+itemHeight);
    }
    return this;
  }
/**
* Arranges the tiles in rows within a specified height.
* This forces the columns, the height and the size of the elements
* @param r how many rows
* @param h the height in pixels
* @param dpc Distance PerCent % of width and height used for space between cols and rows. 0% 0<dpc<=1 100%                                  
*/
  GUITileLayout arrangeByRows(int r, float h, float dpc) {
    if (r>0) {
      rows = r;
      _h = h;
      if(dpc>=0 && dpc<=1) DPC = dpc;
      else DPC = 0.1;
      cols = (collection.size()/rows)+((collection.size()%rows)>0?1:0);
      rowspace = int(_h*DPC/(rows+1));
      colspace = rowspace; 
      itemHeight = int((_h-(rows+1)*rowspace)/rows);
      itemWidth = itemHeight;
      _w = cols*itemWidth + (cols+1)*colspace;
    }
    return this;
  }
/**
* Arranges the tiles in rows specified within all available height.
* This forces the columns, the height and the size of the elements
* @param r how many rows
* @param dpc Distance PerCent % of width and height used for space between cols and rows. 0% 0<dpc<=1 100%                                  
*/  
  GUITileLayout arrangeByRows(int r, float dpc) {
    if (r>0) {
      rows = r;
      if(dpc>=0 && dpc<=1) DPC = dpc;
      else DPC = 0.1;
      cols = (collection.size()/rows)+((collection.size()%rows)>0?1:0);
      rowspace = int(_h*DPC/(rows+1));
      colspace = rowspace; 
      itemHeight = int((_h-(rows+1)*rowspace)/rows);
      itemWidth = itemHeight;
      _w = cols*itemWidth + (cols+1)*colspace;
    }
    return this;
  }
/**
* Arranges the tiles in columns specified within a specified width.
* This forces the rows, height and size of the elements
* @param c how many columns
* @param w the width in pixels
* @param dpc Distance PerCent % of width and height used for space between cols and rows. 0% 0<dpc<=1 100%                                  
*/
  GUITileLayout arrangeByCols(int c, float w, float dpc) {
    if (c>0) {
      cols = c;
      _w = w;
      if(dpc>=0 && dpc<=1) DPC = dpc;
      else DPC = 0.1;
      rows = (collection.size()/cols)+((collection.size()%cols)>0?1:0);
      colspace = int(_w*DPC/(cols+1));
      rowspace = colspace;
      itemWidth = int((_w-(cols+1)*colspace)/cols);
      itemHeight = itemWidth;
      _h = rows*itemHeight + (rows+1)*rowspace;
    }
    return this;
  }
/**
* Arranges the tiles in  columns using all available width.
* This forces the rows, height and size of the elements
* @param c how many columns
* @param dpc Distance PerCent % of width and height used for space between cols and rows. 0% 0<dpc<=1 100%                                  
*/  
  GUITileLayout arrangeByCols(int c, float dpc) {
    if (c>0) {
      cols = c;
      if(dpc>=0 && dpc<=1) DPC = dpc;
      else DPC = 0.1;
      rows = (collection.size()/cols)+((collection.size()%cols)>0?1:0);
      colspace = int(_w*DPC/(cols+1));
      rowspace = colspace;
      itemWidth = int((_w-(cols+1)*colspace)/cols);
      itemHeight = itemWidth;
      _h = rows*itemHeight + (rows+1)*rowspace;
    }
    return this;
  }

  void draw() { 
    super.draw();
    if (isActive) {
      for (int i=0; i<rows*cols; i++) {
        if (i<collection.size()) {
          int x = colspace*((i%cols)+1)+(itemWidth*(i%cols));
          int y = rowspace*((i/cols)+1)+(itemHeight*(i/cols));
          collection.get(i).setSize(itemWidth, itemHeight).setPosition(_x+x, _y+y);
          collection.get(i).draw();
        } else {
          break;
        }
      }
    }
  }

  int getColspace() {
    return colspace;
  }

  int getRowspace() {
    return rowspace;
  }

  int getItemWidth() {
    return itemWidth;
  }

  int getItemHeight() {
    return itemHeight;
  }

  int getCollectionSize() {
    return collection.size();
  }
}
//////////////////////////////////////////////////////////////////
/**
* A toggle button. It can have multiple states
* The default element label is used as button text. Alternatively it can have an icong instead of text
*/

public class GUIToggle extends GUIElement<GUIToggle> {
  private ArrayList<toggleState> state;
  private PImage showPic;
  private int currentState;

/**
* Constructor. When created it only has a single state. You need to add the other states using the addState(String t, PImage image, color c)
* @param t text to be used in the default state of the toggle
* @param image an image to be used in the default state of the toggle
* @param c the BG color of the default state of the toggle
*/
  GUIToggle(String t, String image, color c, float factor) {
    super();   
    state = new ArrayList<toggleState>();
    state.add(new toggleState(t, image, c, factor));
    currentState = 0;
    showPic = state.get(currentState).getImage();
    drawLabel = false;
    label = state.get(currentState).getText();
    BGcolor = state.get(currentState).getColor();
  }

  GUIToggle(String t) {
    super();   
    state = new ArrayList<toggleState>();
    state.add(new toggleState(t));
    currentState = 0;
    drawLabel = false;
    label = state.get(currentState).getText();
  }
  
  toggleState getToggleState(int i) {
    return state.get(i);
  }

/**
* Add further states (can be more than one) to the toggle. The toggle with rotate through the states
* @param t text to be used in the added state of the toggle
* @param image an image to be used in the added state of the toggle
* @param c the BG color of the added state of the toggle
*/
  GUIToggle addState(String t, String image, color c, float factor) {
    state.add(new toggleState(t, image, c, factor)); 
    return this;
  }
  
  GUIToggle addState(String t) {
    state.add(new toggleState(t)); 
    return this;
  }
/**
* Rotates to the next state
*/
  void nextState() {
    if (currentState < state.size()-1) currentState++;
    else currentState = 0;
    float factor = state.get(currentState).getImageScale();
    
    showPic = state.get(currentState).getImage();
    showPic.resize(int(_w*factor), int(_h*factor));
    if (drawLabel) label = state.get(currentState).getText();
    BGcolor = state.get(currentState).getColor();
  }
  
  void previousState(){
    if (currentState > 0){
      currentState--;    
    } 
    else{
      currentState = state.size()-1;
    }
    float factor = state.get(currentState).getImageScale();
    showPic = state.get(currentState).getImage();
    showPic.resize(int(_w*factor), int(_h*factor));
    if (drawLabel) label = state.get(currentState).getText();
    BGcolor = state.get(currentState).getColor();
  }
  
  
  
  
/**
* Rotates to the next state
*/
  void nextStateText() {
    if (currentState < state.size()-1) currentState++;
    else currentState = 0;
    if (drawLabel) label = state.get(currentState).getText();
  }
  
  void previousStateText(){
    if (currentState > 0){
      currentState--;    
    } 
    else{
      currentState = state.size()-1;
    }
    if (drawLabel) label = state.get(currentState).getText();
  }
    
  int getState() {
    return currentState;
  }
/*
  void previousState() {
    if (currentState > 0){
      currentState--;    
    } 
    else{
      currentState = 0;
    }
    float factor = state.get(currentState).getImageScale();
    showPic = state.get(currentState).getImage();
    showPic.resize(int(_w*factor), int(_h*factor));
    if (drawLabel) label = state.get(currentState).getText();
    BGcolor = state.get(currentState).getColor();
  }  
*/
  void draw() {
    if (isActive) {
      rectMode(CORNER);
      if (drawBorder) stroke(borderColor);
      else noStroke();
      if (drawBG) fill(BGcolor); 
      else noFill();
      rect(_x, _y, _w, _h);
      if (showPic !=null) { 
        showPic.resize(int(_w*state.get(currentState).getImageScale()), int(_h*state.get(currentState).getImageScale()));
        image(showPic, _x+_w*(1-state.get(currentState).getImageScale())/2, _y+_h*(1-state.get(currentState).getImageScale())/2);
      } else if (drawLabel) {
        fill(LBLcolor);
        rectMode(CORNER);
        textAlign(CENTER, CENTER);
        textSize(LBLsize);
        text(label, _x, _y, _w, _h);
      }
    }
  }
}

private class toggleState {
  private PImage pic;
  private color bgColor;
  private String text;
  private float imageScaleFactor; // must be <0 and <=1

  toggleState(String t, String image, color c, float imageScale) {
    pic = loadImage(image);
    bgColor = c;
    text = t;
    if(imageScale>0 && imageScale<=1) imageScaleFactor = imageScale;
    else imageScaleFactor = 1;
  }
  
  toggleState(String t){
   text = t;      
  }
  
  
  toggleState(String t, String image, color c) {
    pic = loadImage(image);
    bgColor = c;
    text = t;
    imageScaleFactor=1;
  }

  PImage getImage() {
    return pic;
  }

  color getColor() {
    return bgColor;
  }

  String getText() {
    return text;
  }
  
  float getImageScale(){
    return imageScaleFactor;  
  }
  
  void setImageScale(float sc){
    if(sc>0 && sc<=1) imageScaleFactor = sc;
    else imageScaleFactor = 1;
  }

  void setImage(String image) {
    pic = loadImage(image);
  }

  void setColor(color c) {
    bgColor = c;
  }

  void setText(String t) {
    text = t;
  }
}
//////////////////////////////////////////////////////////////////
