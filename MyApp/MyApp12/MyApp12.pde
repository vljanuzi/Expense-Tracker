
import controlP5.*;

import ketai.camera.*;
import ketai.cv.facedetector.*;
import ketai.data.*;
import ketai.net.*;
import ketai.net.bluetooth.*;
import ketai.net.nfc.*;
import ketai.net.nfc.record.*;
import ketai.net.wifidirect.*;
import ketai.sensors.*;
import ketai.ui.*;

import ketai.ui.*;  
import android.view.MotionEvent; 

//Global declarations. They will be available in all classes you create

//First some colors to use. Add your own palette here for easy use. 
color red = color(255, 0, 0);
color green = color(0, 255, 0);
color blue = color(0, 0, 255);
color black = color(0, 0, 0);
color white = color(255, 255, 255);
color orange = color(255, 195, 0); 

//A Ketai object used to identify the gesture on the touch screen. See the Ketai reference
KetaiGesture gesture; 
//A self reference to app.
PApplet app;

//The state controller. It will be used to change screens. See the GUIController class for more details
GUIController guiControl;
//declaring the screens of the app. All screens of the application should be GUIContainer objects. Add your own here
GUIContainer<GUIGridLayout> mainMenu;
GUIContainer<GUIGridLayout> transferMoney;
GUIContainer<GUIGridLayout> accounts;
GUIContainer<GUIGridLayout> addExpense;
GUIContainer<GUIGridLayout> addAccount;
GUIContainer<GUIGridLayout> expenses;
GUIContainer<GUIGridLayout> editAccount;
GUIContainer<GUIGridLayout> test;
KetaiLocation location;
KetaiCamera cam;
double longitude, latitude, altitude;
float accuracy;

private ControlP5 cp5;

ExpenseTracker core;
ListBox listbox;



void setup() {
  fullScreen(); 
  //Needed to extend to all the available screen size
  orientation(PORTRAIT);                       //Can also be set to LANDSCAPE
  guiControl = new GUIController();            
  gesture = new KetaiGesture(this);
  app = this;
  core = new ExpenseTracker();
  
  Account bank = new Account("Bank", 5000);
  Account wallet = new Account("Wallet", 300);
  
  //accounts
   core.addAccount(bank);
   core.addAccount(wallet);
   
    Category food = new Category("Food");  
    Category utilities = new Category("Utilities");    
    

      bank.addExpense("Chicken sandwich", 3.5, food);
      bank.addExpense("Dinner", 80, food);
      bank.addExpense("Rent", 800, utilities);
      bank.addExpense("Electricity", 250, utilities);
      bank.addExpense("Water", 120, utilities);


  cp5 = new ControlP5(this);
  mainMenu = new MainMenu();       //For each screen declared, first make the screen
  transferMoney = new TransferMoney();
  addExpense = new AddExpense();
  addAccount = new AddAccount();
  accounts = new Accounts();
  test = new Test();
  expenses = new Expenses();
  editAccount = new EditAccount();

  guiControl.addScreen(mainMenu);        //then add it to the controller
  guiControl.addScreen(transferMoney);        //then add it to the controller
  guiControl.addScreen(addExpense); //then add it to the controller
  guiControl.addScreen(addAccount);
  guiControl.addScreen(expenses);        //then add it to the controller
  guiControl.addScreen(accounts);        //then add it to the controller
  guiControl.addScreen(test);        //then add it to the controller
  guiControl.addScreen(editAccount);


  guiControl.activateScreen(mainMenu);   //select a screen from those you build as the starting screen

  
  location = new KetaiLocation(this);
  //cam = new KetaiCamera(this, 1320, 1240, 50);
  //imageMode(CENTER);
}


void draw() {
  background(255);                             //repaint the background
  guiControl.draw();                           //draw the active screen
  //drawMousePointer();
  /*if (cam.isStarted()) {
    image(cam, width, height);
  }
  if (location.getProvider() == "none") {
    println("not available");
    
  } else {
    //text("latitude: " + latitude + "\n longitude" + longitude, width/2, height/2);
  }*/
}

void onCameraPreviewEvent() {
  cam.read();
}

void mousePressed() {
    guiControl.alert(MOUSEPRESS);
/*
  if(cam.isStarted()) {
    cam.stop();
  } else {
    cam.start();
  }*/
  
}
void onLocationEvent(double _latitude, double _longitude, double _altitude, float _accuracy) {
  longitude = _longitude;
  latitude = _latitude;
  altitude = _altitude;
  accuracy = _accuracy;
  println("latitude " + latitude);
}

void drawMousePointer() {
  stroke(0);
  fill(255);
  ellipse(mouseX, mouseY, 5, 5);
}


//informing the GUI about processing I/O events
//mouse events
/*
void mousePressed() {                          
  guiControl.alert(MOUSEPRESS);
}
*/
void mouseReleased() {                       
  guiControl.alert(MOUSERELEASE);
}

public void mouseDragged(){
  guiControl.alert(MOUSEDRAG);  
}

//Keyboard events
public void keyPressed() {                     
  guiControl.alert(KEYPRESS);
}

public void keyReleased() {                    
 
  guiControl.alert(KEYRELEASE);
}

//Gesture events
public void onTap(float x, float y){
  guiControl.alert(TAP);
}

public void onDoubleTap(float x, float y){
  guiControl.alert(DOUBLETAP);
}

public void onLongPress(float x, float y){
  guiControl.alert(LONGPRESS);
}

public void onPinch(float x, float y, float r){
  guiControl.alert(PINCH);
}

public void onRotate(float x, float y, float a){
  guiControl.alert(ROTATE);
}

public boolean surfaceTouchEvent(MotionEvent event) {  
  //call to keep mouseX and mouseY constants updated
  super.surfaceTouchEvent(event);
  //forward events
  return gesture.surfaceTouchEvent(event);
}
