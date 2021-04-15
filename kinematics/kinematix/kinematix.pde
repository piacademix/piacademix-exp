PVector target;
PVector position;
PVector velocity;

float distance=0.0;
float h=300.0;
float gravity= -18;
float displacement=0.0;
float dt=0.0;
float totalTime=0;
float time_now;

float vel;
float posx=0.0;
float posy=0.0;
float total_time=0.0;
String deltaTime="";
float vy=0.0;
float delta_time_step =0.01f;

float padding=10;



void setup()
{
  size(800, 600);
  init();
  calculate_velocity();
}

void draw()
{
  
  background(0);
  update(posx, posy);
  drawPath();
  if (dt<=total_time)
  {
    posx=position.x + velocity.x*dt;
    posy =position.y + (velocity.y*dt) + (0.5*gravity*dt*dt);   
    update(posx, posy);
    drawvelocityVector(posx ,posy,dt );
    deltaTime = "Time =" + str(dt);
    
    textSize(22);
    fill(255);
    text(deltaTime,10,35);
    
    dt+= delta_time_step ;
    
  } 
  else
  {
    
    dt=0;
    init();
    calculate_velocity();
  }
}


void update(float  px, float py)
{
  //draw axis
  strokeWeight(3);
  stroke(0, 255, 0);
  line(10, 0, 10, height);

  stroke(255, 0, 0);
  line(0, height-10, width, height-10);

  //Position
  strokeWeight(1);
  stroke(255);
  fill(255);
  circle(px+padding, (height - padding) - py, 12);
  stroke(0,255,0);
  line(padding,(height - padding)-py ,px, (height - padding) - py);
  text(str(posy) , (padding+5),((height - padding)-py)- 20);
  
  stroke(255,0,0);
  line(px+padding,(height - padding), px+padding,(height - padding) - py);
  
  text(str(posx) ,px+ padding+5,height - padding- 20);

  //target
  stroke(0, 255, 0);
  fill(255, 0, 0);
  circle(target.x+padding, (height - padding) - target.y, 30);
  
  strokeWeight(1);
  
  
}
void drawvelocityVector(float px ,float py,float t )
{
  strokeWeight(3);
  vy=velocity.y + gravity*t;
  stroke(0,255,0);
  line(px+padding, (height - padding) - py ,px+padding, ((height - padding)-py)-vy);
  textSize(12);
  fill(0,255,0);
  text("Vy" ,px+padding ,((height - padding)-py)-vy);
  
  stroke(255,0,0);
  line(px+padding, (height - padding) - py ,(px+padding)+velocity.x, (height - padding) - py);
   textSize(12);
  fill(255);
  text("Vx" ,(px+padding)+velocity.x ,(height - padding) - py);
  strokeWeight(1);
  
}

void drawPath()
{
  float px=0.0;
  float py=0.0;
  for(float t =0.0 ; t <= total_time; t+=0.2 )
  {
    px= position.x + velocity.x * t;
    py = position.y + ( velocity.y * t) + ( 0.5 * gravity * t * t);   
    
     stroke(255);
     fill(125,255,125);
    
    circle(px + padding, (height - padding) - py, 3);
    
  }
}

void init()
{
  position=new PVector(0.0, 0.0);
  target=new PVector(random(100, 600), random(0, 300));
  velocity =new PVector(1.0, 1.0);
}

void calculate_velocity()
{

  float distanceX = target.x - position.x;
  float distanceY = target.y - position.y;
  
  h=abs( distanceY + 100 );
  
  float velocityY=sqrt( -2.0*gravity*h );
  
  float timeUp=sqrt( -2.0*h/gravity );
  
  float timeDown = sqrt( 2.0*(distanceY-h) / gravity );  
  
  total_time= timeUp + timeDown;
  
  float velocityX= distanceX / total_time; 
  
  velocity.set( velocityX , velocityY );


  println("Position =" +position);
  println("Target Position =" +target);
  println("Velocity =" + velocity);
  println("Distance X = " +distanceX);
  println("Distance Y = " +distanceY);
  println("Velocity X =" + velocityX);
  println("Velocity Y =" + velocityY);
  println("Time Up =  " + timeUp);
  println("Time Down =" + timeDown);
  println("TotalTime = " + total_time); 

}
