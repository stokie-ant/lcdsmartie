#include <windows.h>

#define DLLEXPORT __declspec(dllexport)


/*********************************************************
 *         Function 1                                    *
 *  Simply returns "This is function 1"           *      *
 *********************************************************/
extern "C" DLLEXPORT  char * 
__stdcall  function1(char *param1, char *param2)
{
    return "This is function 1";       
}


/*********************************************************
 *         Function 2                                    *
 *  Returns how many times the function has been called. *
 *********************************************************/
extern "C" DLLEXPORT  char * 
__stdcall  function2(char *param1, char *param2)
{
    static char outbuf[1000];
    static int count;
    
    count ++;
    
    itoa(count, outbuf, 10);
    return outbuf;       
}
    


BOOL APIENTRY DllMain (HINSTANCE hInst     /* Library instance handle. */ ,
                       DWORD reason        /* Reason this function is being called. */ ,
                       LPVOID reserved     /* Not used. */ )
{
    switch (reason)
    {
      case DLL_PROCESS_ATTACH:
        break;

      case DLL_PROCESS_DETACH:
        break;
    }

    /* Returns TRUE on success, FALSE on failure */
    return TRUE;
}
