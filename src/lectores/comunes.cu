#include "../PuntoPertenecia.h"

void split(vector<string> &theStringVector, const string &theString, const string &theDelimiter);
 

/**
 * @brief 
 * 
 * @param theStringVector 
 * @param theString 
 * @param theDelimiter 
 */
void split(vector<string> &theStringVector, const string &theString, const string &theDelimiter) {
    size_t start = 0, end = 0;

    while (end != string::npos) {
        end = theString.find(theDelimiter, start);

        // If at end, use length=maxLength.  Else use length=end-start.
        theStringVector.push_back(theString.substr(start,
                                                   (end == string::npos) ? string::npos : end - start));

        // If at end, use start=maxSize.  Else use start=end+delimiter.
        start = ((end > (string::npos - theDelimiter.size()))
                 ? string::npos : end + theDelimiter.size());
    }
}