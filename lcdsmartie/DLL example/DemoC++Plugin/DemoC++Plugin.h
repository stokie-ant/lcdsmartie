// The following ifdef block is the standard way of creating macros which make exporting 
// from a DLL simpler. All files within this DLL are compiled with the DEMOCPLUGIN_EXPORTS
// symbol defined on the command line. this symbol should not be defined on any project
// that uses this DLL. This way any other project whose source files include this file see 
// DEMOCPLUGIN_API functions as being imported from a DLL, whereas this DLL sees symbols
// defined with this macro as being exported.
#ifdef DEMOCPLUGIN_EXPORTS
#define DEMOCPLUGIN_API __declspec(dllexport)
#else
#define DEMOCPLUGIN_API __declspec(dllimport)
#endif

// This class is exported from the DemoC++Plugin.dll
class DEMOCPLUGIN_API CDemoCPlugin {
public:
	CDemoCPlugin(void);
	// TODO: add your methods here.
};

extern DEMOCPLUGIN_API int nDemoCPlugin;

DEMOCPLUGIN_API int fnDemoCPlugin(void);
