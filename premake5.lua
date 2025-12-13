project "Assimp"
    kind "StaticLib"
    language "C++"
    cppdialect "C++20"
    staticruntime "on"

    targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
    objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "code/**.h",
        "code/**.cpp",
        "include/**.h",
        "include/**.hpp",
        "include/**.inl",
        
        -- Dependencias internas necesarias (Zlib, Unzip, etc)
        -- Si ya tenés zlib en tu engine por otro lado, podés quitar esto y linkearlo.
        "contrib/zlib/**.h",
        "contrib/zlib/**.c",
        "contrib/zlib/**.cpp",
        "contrib/unzip/**.h",
        "contrib/unzip/**.c",
        "contrib/irrXML/**.h",
        "contrib/irrXML/**.cpp",
        "contrib/pugixml/src/**.hpp",
        "contrib/pugixml/src/**.cpp",
        "contrib/utf8cpp/source/**.h",
        "contrib/openddlparser/code/**.cpp",
    }

    removefiles
    {
        -- Excluir pruebas y herramientas
        "code/Tests/**",
        "code/Pbrt/**", -- A veces da problemas si no se configura bien
        "test/**",
        "tools/**",
        "samples/**",

        -- Excluir toda la lógica de exportación (Exporters)
        "code/**/*Exporter.cpp",
        "code/**/*Exporter.h",
        "code/**/*Export*",
        
        -- Opcional: A veces PostProcessing también tiene archivos que sobran
        "code/PostProcessing/*Exporter*",

        -- Excluir wrappers de C++ viejos y otros ejemplos de zlib que no necesitamos
        "contrib/zlib/contrib/iostream/**",
        "contrib/zlib/contrib/iostream2/**",
        "contrib/zlib/contrib/ada/**",
        "contrib/zlib/contrib/delphi/**",
        "contrib/zlib/contrib/dotzlib/**",
        "contrib/zlib/contrib/pascal/**",
    }

    includedirs
    {
        "include",
        "code",
        ".",
        "contrib/zlib",
        "contrib/unzip",
        "contrib/irrXML",
        "contrib/rapidjson/include",
        "contrib/pugixml/src",
        "contrib/utf8cpp/source",
        "contrib/openddlparser/include",
    }

    defines
    {
        -- Definiciones para asegurar que Assimp compile estáticamente
        "ASSIMP_BUILD_NO_OWN_ZLIB=0", 
        "_CRT_SECURE_NO_WARNINGS" -- Para compatibilidad si compilás en Windows luego
    }

    filter "system:linux"
        pic "On"
        systemversion "latest"
        defines 
        { 
            "ASSIMP_BUILD_NO_EXPORT",
            "ASSIMP_BUILD_NO_M3D_IMPORTER", 
            "ASSIMP_BUILD_NO_C4D_IMPORTER", 
            "ASSIMP_BUILD_NO_IFC_IMPORTER",
            "ASSIMP_BUILD_NO_USD_IMPORTER",
            "ASSIMP_BUILD_NO_VRML_IMPORTER",
        } -- A veces el importador M3D falla en GCC sin configuración extra

        removefiles
        {
            "contrib/zlib/contrib/minizip/iowin32.c",
            "contrib/zlib/contrib/minizip/iowin32.h",
            "contrib/zlib/contrib/testzlib/testzlib.c",
            "contrib/zlib/contrib/testzlib/testzlib.h"
        }

    filter "system:windows"
        systemversion "latest"
        defines { "WIN32_LEAN_AND_MEAN" }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
        runtime "Release"
        optimize "On"