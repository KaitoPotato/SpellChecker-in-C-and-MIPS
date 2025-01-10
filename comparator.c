#include <stdio.h>

/*
 * Print character
 */
void print_char(const char c)
{
   printf("%c",c);
}


/*
 * Print signed int
 */
void print_int(const int i)
{
   printf("%d",i);
}


/*
 * Print string
 */
void print_string(const char *s)
{
   printf("%s",s);
}


/*
 * String comparison function like "strcmp"
 */
int my_strcmp(const char *s1, const char *s2)
{
  int result = 0;
  // search for the first differing character until we reach the end of one of the strings
  // we don't need to check *s2 != '\0` since the first condition for the loop to continue
  // is that *s1 equals *s2. If *s1 equals *s2 and *s1 isn't '\0`, that means *s2 isn't '\0` either
  while (*s1 == *s2 && *s1 != '\0') {
    s1++;
    s2++;
  }

  // if both strings have ended, they are equal
  if (*s1 == '\0' && *s2 == '\0') {
    return 0;
  }

  // here, we compare the first differing character
  if (*s1 > *s2) {
    return 1;
  } else {
    return -1;
  }
}


/*
 * Try out string comparison function
 */
void compare(const char* a, const char* b) {
  printf("my_strcmp(\"%s\", \"%s\") = %d\n", a, b, my_strcmp(a, b));
}


int main(int argc, const char *argv[])
{
  /* Only pass if exactly two command line parameters (in addition to the command itself) have been provided */
  if (argc != 3) {
    return 1;
  }

  compare(argv[1], argv[2]);

  return 0;
}

