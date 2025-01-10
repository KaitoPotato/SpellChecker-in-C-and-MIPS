#ifndef LIBSTRING_H_
#define LIBSTRING_H_

#include <stdlib.h>


/* strlen
 *
 * Returns the length of the C string str.
 * The length of a C string is determined by the terminating null-character: 
 * A C string is as long as the number of characters between the beginning of 
 * the string and the terminating null character (without including the terminating null character itself).
 * This should not be confused with the size of the array that holds the string.
 */
size_t strlen ( const char * str );


/* strncpy
 *
 * Copies the first num characters of source to destination. 
 * If the end of the source C string (which is signaled by a null-character) is found 
 * before num characters have been copied, destination is padded with zeros until a 
 * total of num characters have been written to it.
 * No null-character is implicitly appended at the end of destination if source is
 * longer than num. Thus, in this case, destination shall not be considered a null 
 * terminated C string (reading it as such would overflow).
 * 
 * destination and source shall not overlap.
 */
char * strncpy ( char * destination, const char * source, size_t num );


/* strcspn
 *
 * Get span until character in string
 * Scans str1 for the first occurrence of any of the characters that are part of str2, 
 * returning the number of characters of str1 read before this first occurrence.
 * The search includes the terminating null-characters.
 * Therefore, the function will return the length of str1 if none of the characters of str2 are found in str1.
 */
size_t strcspn ( const char * str1, const char * str2 );

#endif
