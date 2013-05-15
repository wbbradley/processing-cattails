Node root_nodes[];
int stemCount = 12;
float wind_angle = 0;
float wind_angular_velocity = 0;
float max_wind_angle = 0.15;
float min_wind_angle = -0.15;

void setup()
{
  size(680, 500);
  root_nodes = new Node[stemCount];
  for (int i = 0; i != root_nodes.length; i++)
  {
    root_nodes[i] = new Node(null, 0, random(30, 80), 0);
  }
  colorMode(HSB, 100);
  
  PFont font = createFont("Georgia", 14);
  textFont(font);
}

void draw()
{
  background(color(0));//6, 20, 50, 30));
  for (int i = 0; i != root_nodes.length; i++)
  {
    root_nodes[i].draw(
      lerp(width * 0.15, width * 0.85, float(i) / (stemCount - 1)),
      height + 40,
      -PI/2,
      wind_angle);
    root_nodes[i].addChild();
  }
  wind_angle += wind_angular_velocity;
  wind_angular_velocity += random(-0.01, 0.01);
        wind_angular_velocity = min(wind_angular_velocity, 0.1);
        wind_angular_velocity = max(wind_angular_velocity, -0.1);
        wind_angle = min(wind_angle, max_wind_angle);
        wind_angle = max(wind_angle, min_wind_angle);
  //text("wind angle: " + wind_angle, 0, 20);
  //text("wind angular velocity: " + wind_angular_velocity, 0, 40);
  //saveFrame("frames/plants-01-######.tif");
}


