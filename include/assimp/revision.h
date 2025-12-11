#ifndef ASSIMP_REVISION_H_INC
#define ASSIMP_REVISION_H_INC

// Como no estamos ejecutando scripts de git en el build, ponemos 0
// Si pusieramos un hash real sería algo como 0x1234abcd
#define GitVersion 0x0
#define GitBranch "main"

// Definimos una versión manual (5.4.3 es una apuesta segura actual)
#define VER_MAJOR 6
#define VER_MINOR 0
#define VER_PATCH 2
#define VER_BUILD 0

// Macros de ayuda (se mantienen igual)
#define STR_HELP(x) #x
#define STR(x) STR_HELP(x)

#define VER_FILEVERSION             VER_MAJOR,VER_MINOR,VER_PATCH,VER_BUILD

#if (GitVersion == 0)
#define VER_FILEVERSION_STR         STR(VER_MAJOR) "." STR(VER_MINOR) "." STR(VER_PATCH) "." STR(VER_BUILD)
#else
#define VER_FILEVERSION_STR         STR(VER_MAJOR) "." STR(VER_MINOR) "." STR(VER_PATCH) "." STR(VER_BUILD) " (Commit custom)"
#endif

#define VER_COPYRIGHT_STR           "\xA9 2006-2025"

// Esto define el nombre original del DLL. 
// Como estamos compilando como librería estática (StaticLib), esto es irrelevante
// pero necesario para que el código compile sin errores.
#ifdef  NDEBUG
#define VER_ORIGINAL_FILENAME_STR   "assimp.dll"
#else
#define VER_ORIGINAL_FILENAME_STR   "assimpd.dll"
#endif //  NDEBUG

#endif // ASSIMP_REVISION_H_INC