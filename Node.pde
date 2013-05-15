int childCount = 3;
float strokeSize = 2;
float minStemLen = 2;
float maxStemLen = 180;
float maxStep = 10;
float maxStemWeight = 4;

class Node
{
  Node(Node parent, float angle, float len, float step)
  {
    this.len = len;
    this.angle = angle;
    this.step = step;
    this.parent = parent;
    this.invStep = (maxStep - step) / maxStep;
    //println("adding node with color " + lerp(20, 10, step/maxStep) + "," + invStep * 76 + "," + invStep * 100 + "," + lerp(99, 70, step/maxStep));
    this.angular_velocity = 0;
    this.min_angle = -PI/4 + random(-PI/16,PI/16);
    this.max_angle = PI/4 + random(-PI/16,PI/16);
    this.col = color(
        lerp(11, 24, step/maxStep),
        lerp(30, 80, step/maxStep),
        lerp(30, 80, step/maxStep),
        lerp(99, 70, step/maxStep));
    this.node = new Node[childCount];
  }
  void draw(float px, float py, float angle, float wind_angle)
  {
    //fill(col);
    //ellipse(px, py, nodeSize, nodeSize);
    for (int i = 0; i < childCount; ++i)
    {
      if (node[i] != null)
      {
        float cur_angle = node[i].angle + angle;
        float dx = cos(cur_angle) * len;
        float dy = sin(cur_angle) * len;
        if (step > 5)
        {
          strokeWeight(maxStemWeight * 5 * invStep);
          stroke(color(lerp(50, 60, invStep), 50, 70, lerp(90, 70, invStep)));
        }
        else
        {
          strokeWeight(maxStemWeight * invStep);// * maxStemWeight);//abs(cur_angle * 200/ len));
          stroke(node[i].col);//color(invStep * 100, invStep * 100, invStep * 100, invStep * 255));
        }
        line(px, py, px + dx, py + dy);
        //fill(100);
        //text(lerp(20, 10, step/maxStep)/*(col&0xff0000)>>16*/, px + dx * 0.5, py + dy * 0.5);
        
        /* mutate*/
      
       this.angle += this.angular_velocity;
        this.angular_velocity += random(-0.001 * step, 0.001 * step);
        this.angular_velocity = min(this.angular_velocity, 0.01);
        this.angular_velocity = max(this.angular_velocity, -0.01);
        if (this.parent != null)
          this.angular_velocity += parent.angular_velocity * 0.3;
        this.angle = lerp(this.angle, wind_angle, 0.05);
        this.angle = min(this.angle, max_angle);
        this.angle = max(this.angle, min_angle);
        if (this.len < maxStemLen * invStep)
          this.len *= random(1.00, 1 + .001 / (step + 1));
       
        node[i].draw(px + dx, py + dy, cur_angle + wind_angle * 0.2, wind_angle);
      }
    } 
  }
  void addChild()
  {
    if (step > maxStep)
      return;
      
    if (len > minStemLen)
    {
      int index = (int)random(0, childCount);
      if (node[index] != null)
      {
        node[index].addChild();
      }
      else
      {
        node[index] = new Node(this, random(-0.5 * invStep, 0.5 * invStep), len * random(0.57, 1.01), this.step + 1);
      }
    }
  }
  Node parent;
  Node node[];
  float angle, len, angular_velocity;
  float min_angle, max_angle;
  float step, invStep;
  color col;
};
