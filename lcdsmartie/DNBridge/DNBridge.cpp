#include "stdafx.h"
#include "DNBridge.h"

#include <windows.h>
#include <string.h>
#include <_vcclrit.h>

#using <mscorlib.dll>

using namespace System;
using namespace System::Reflection;

__gc class  globals {
public:
	static Assembly __gc *myAssembly;
	static Type __gc *myType;
	static Object __gc *myObject;
	static MethodInfo __gc *myMethods[];
};


extern "C"
{

__declspec(dllexport) void __stdcall SmartieInit(void) 
{
    __crt_dll_initialize();
}

__declspec(dllexport) char * __stdcall BridgeInit(const char *param1) 
{
	String __gc *result = new String("");

	try
	{
		String __gc *managed_param1 = new String(param1);    
		String __gc *loadPath = managed_param1->Concat(S"plugins\\", managed_param1);
		String __gc *classtype = managed_param1;
		if (classtype->LastIndexOf(S".") != -1)
			classtype = managed_param1->Substring(0, classtype->LastIndexOf(S"."));
		classtype = classtype->Concat(classtype, S".LCDSmartie");

		globals::myAssembly = Assembly::LoadFrom( loadPath );
		if (globals::myAssembly)
		{
			globals::myType = globals::myAssembly->GetType(classtype);
			if (globals::myType)
			{
				globals::myObject = Activator::CreateInstance(globals::myType);

				if (globals::myObject)
				{
					globals::myMethods = new MethodInfo*[20];
					bool found = false;

					for (int iFunc=1; iFunc<=20; iFunc++) 
					{
						String __gc *function = String::Concat(S"function", iFunc.ToString());
						globals::myMethods[iFunc-1] = globals::myType->GetMethod(function);
						if (globals::myMethods[iFunc-1])
							found = true;
					}
					
					if (!found)
						result = S"Class contains no Smartie methods!";
				}
				else result = S"Failed to create an instance";
			}
			else result = String::Concat(S"Plugin does not contain a type of ", classtype);
		}
		else result = String::Concat(S"Failed to load ", loadPath);
	} catch (Exception *e) {
		String __gc *err = new String("[Exception: ");
		result = String::Concat(err, e->Message, S"]");
	}

	static char buffer[1024];
	buffer[0] = 0;
	if (result != "")
	{
		char tmp __gc[] = System::Text::Encoding::UTF8->GetBytes(result->ToCharArray());
		char __pin *value = &tmp[0];
			
		strncpy(buffer, value, 1024);
	}
	return buffer;
}
 

char *callit(int iFunc, const char *param1, const char *param2)
{
	String __gc *managed_param1 = new String(param1);
	String __gc *managed_param2 = new String(param2);
	String __gc *result = new String("");

	// 0 based array
	iFunc--;

	try
	{
		if (!globals::myMethods || !globals::myMethods[iFunc])
			result = "[Dll: function not found]";
		else
		{
			String __gc *args[] = new String*[2];
			args[0] = managed_param1;
			args[1] = managed_param2;

			result = static_cast<String*>(globals::myMethods[iFunc]->Invoke(globals::myObject, args));
		}

   	}catch(Exception *e){
		String __gc *err = new String("[Exception: ");
		result = err->Concat(err, e->Message, S"]");
	}

	static char buffer[1024];
	buffer[0] = 0;
	if (result != "")
	{
		char tmp __gc[] = System::Text::Encoding::UTF8->GetBytes(result->ToCharArray());
		char __pin *value = &tmp[0];
	
		strncpy(buffer, value, 1024);
	}
	return buffer;
}


__declspec(dllexport) char *__stdcall function1(const char *param1, const char *param2) 
{
	return callit(1, param1, param2);
}

__declspec(dllexport) char *__stdcall function2(const char *param1, const char *param2) 
{
	return callit(2, param1, param2);
}

__declspec(dllexport) char *__stdcall function3(const char *param1, const char *param2) 
{
	return callit(3, param1, param2);
}

__declspec(dllexport) char *__stdcall function4(const char *param1, const char *param2) 
{
	return callit(4, param1, param2);
}

__declspec(dllexport) char *__stdcall function5(const char *param1, const char *param2) 
{
	return callit(5, param1, param2);
}

__declspec(dllexport) char *__stdcall function6(const char *param1, const char *param2) 
{
	return callit(6, param1, param2);
}

__declspec(dllexport) char *__stdcall function7(const char *param1, const char *param2) 
{
	return callit(7, param1, param2);
}

__declspec(dllexport) char *__stdcall function8(const char *param1, const char *param2) 
{
	return callit(8, param1, param2);
}

__declspec(dllexport) char *__stdcall function9(const char *param1, const char *param2) 
{
	return callit(9, param1, param2);
}

__declspec(dllexport) char *__stdcall function10(const char *param1, const char *param2) 
{
	return callit(10, param1, param2);
}

__declspec(dllexport) char *__stdcall function11(const char *param1, const char *param2) 
{
	return callit(11, param1, param2);
}

__declspec(dllexport) char *__stdcall function12(const char *param1, const char *param2) 
{
	return callit(12, param1, param2);
}

__declspec(dllexport) char *__stdcall function13(const char *param1, const char *param2) 
{
	return callit(13, param1, param2);
}

__declspec(dllexport) char *__stdcall function14(const char *param1, const char *param2) 
{
	return callit(14, param1, param2);
}

__declspec(dllexport) char *__stdcall function15(const char *param1, const char *param2) 
{
	return callit(15, param1, param2);
}

__declspec(dllexport) char *__stdcall function16(const char *param1, const char *param2) 
{
	return callit(16, param1, param2);
}

__declspec(dllexport) char *__stdcall function17(const char *param1, const char *param2) 
{
	return callit(17, param1, param2);
}

__declspec(dllexport) char *__stdcall function18(const char *param1, const char *param2) 
{
	return callit(18, param1, param2);
}

__declspec(dllexport) char *__stdcall function19(const char *param1, const char *param2) 
{
	return callit(19, param1, param2);
}

__declspec(dllexport) char *__stdcall function20(const char *param1, const char *param2) 
{
	return callit(20, param1, param2);
}

}
