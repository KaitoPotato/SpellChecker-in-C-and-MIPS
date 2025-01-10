#include "libio.h"
#include "libstring.h"

char *separators = " ()[].,;?!:\"#0123456789\000";


void tokenize(const char *str)
{
  size_t offset = 0;
  size_t first;
  char token[30];

  do {
    first = strcspn(str + offset, separators);
    if (0 != first) {
      printString("Token = ");
      strncpy(token,str + offset, first);
      token[first] = 0;
      printString(token);
      printLn();
    }
    offset += first + 1;
  } while (0 != strlen(str + offset - 1));
}


int main(int argc, const char *argv[])
{
  /* Terminate if not command line option provided */
  if (argc != 2)
    return 1;

  printString("Input = ");
  printString(argv[1]);
  printLn();
  tokenize(argv[1]);
  
  return 0;
}

