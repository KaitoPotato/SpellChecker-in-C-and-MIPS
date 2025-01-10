#include "libstring.h"


size_t strlen(const char* str) {
    size_t len = 0;
    while (*str != '\0') {
        len++;
        str++;
    }
    return len;
}


char * strncpy (char *destination, const char *source, size_t num)
{
  size_t i;
  
  for (i = 0; i < num && source[i] != '\0'; i++)
    destination[i] = source[i];
  for ( ; i < num; i++)
    destination[i] = '\0';
  
  return destination;
}


/*
 * Span the complement of string s2.
 */
size_t strcspn ( const char * str1, const char * str2 )
{
  const char *p, *spanp;
  char c, sc;
  
  /*
   * Stop as soon as we find any character from s2.  Note that there
   * must be a NUL in s2; it suffices to stop when we find that, too.
   */
  for (p = str1;;) {
    c = *p++;
    spanp = str2;
    do {
      if ((sc = *spanp++) == c)
	return (p - 1 - str1);
    } while (sc != 0);
  }
  /* NOTREACHED */
}
