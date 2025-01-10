#include "libio.h"
#include <stdio.h>


void printInt(int32_t i)
{
  printf("%d",i);
}
  
void printChar(char c)
{
  printf("%c",c);
}

void printString(const char *s)
{
  printf("%s",s);
}

void printLn()
{
  printf("\n");
}


int32_t readInt()
{
  int32_t myInt;
  scanf("%d", &myInt);

  return myInt;
}
