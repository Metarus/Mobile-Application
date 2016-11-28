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
  }
  void update()
  {
    ellipse(x, y, 20, 20);
    existenceCount++;
    if (existenceCount%delay==0)
    {
      v1.x=player.x-x;
      v1.y=player.y-y;
      v1.normalize();
      normalProjectiles.add(new ProjectileNormal(x, y, v1.x, v1.y));
    }
  }
}