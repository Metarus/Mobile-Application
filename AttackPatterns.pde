//Different attack patterns
void Attack1()
{
  killAll();

  for (int i=0; i<100; i++)
  {
    normalProjectiles.add(new ProjectileNormal(random(width), 0, 0, 6));
  }
}
void Attack2()
{
  killAll();

  for (int i=0; i<5; i++)
  {
    homingProjectiles.add(new ProjectileHoming(random(width), 0, 0, 0));
    homingProjectiles.add(new ProjectileHoming(0, random(height), 0, 0));
    homingProjectiles.add(new ProjectileHoming(random(width), height, 0, 0));
    homingProjectiles.add(new ProjectileHoming(width, random(height), 0, 0));
  }
}
void Attack3()
{
  killAll();

  for (int i=0; i<5; i++)
  {
    accurateHomingProjectiles.add(new ProjectileHomingAccurate(random(width), 0, 0, 0));
    accurateHomingProjectiles.add(new ProjectileHomingAccurate(0, random(height), 0, 0));
    accurateHomingProjectiles.add(new ProjectileHomingAccurate(random(width), height, 0, 0));
    accurateHomingProjectiles.add(new ProjectileHomingAccurate(width, random(height), 0, 0));
  }
}
void Attack4()
{
  killAll();

  for (int i=0; i<50; i++)
  {
    normalProjectiles.add(new ProjectileNormal(random(width), 0, 0, 6));
    normalProjectiles.add(new ProjectileNormal(random(width), -500, 0, 6));
  }
  for (int i=0; i<5; i++)
  {
    accurateHomingProjectiles.add(new ProjectileHomingAccurate(0, random(height), 0, 0));
    accurateHomingProjectiles.add(new ProjectileHomingAccurate(width, random(height), 0, 0));
  }
}
void Attack5()
{
  killAll();

  for (int i=0; i<40; i++)
  {
    normalProjectiles.add(new ProjectileNormal(random(width), 0, 0, 8));
    normalProjectiles.add(new ProjectileNormal(random(width), -300, 0, 8));
    normalProjectiles.add(new ProjectileNormal(random(width), -600, 0, 8));
  }
}
void Attack6()
{
  killAll();

  for (int i=0; i<5; i++)
  {
    accurateHomingProjectiles.add(new ProjectileHomingAccurate(0, random(height), 0, 0));
    accurateHomingProjectiles.add(new ProjectileHomingAccurate(width, random(height), 0, 0));
    homingProjectiles.add(new ProjectileHoming(random(width), height, 0, 0));
    homingProjectiles.add(new ProjectileHoming(random(width), 0, 0, 0));
  }
}