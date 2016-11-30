class ProjectileShooter
{
  float x, y, delay, existenceCount;
  PVector v1;
  ProjectileShooter(float _x, float _y, int _delay, int offset)
  {
    x=_x;
    y=_y;
    delay=_delay;
    existenceCount=offset;
    v1 = new PVector(0, 0);
  }
  void update()
  {
    fill(0);
    ellipse(x, y, 50, 50);
    existenceCount++;
    if (existenceCount%delay==0)
    {
      v1.x=player.x-x;
      v1.y=player.y-y;
      v1.normalize();
      normalProjectiles.add(new ProjectileNormal(x, y, v1.x*10, v1.y*10));
    }
  }
}