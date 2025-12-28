project "Assimp"
    kind "StaticLib"
    language "C++"
    cppdialect "C++20"
    staticruntime "on"
    warnings "Off"

    targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
    objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "code/**.h",
        "code/**.cpp",
        "include/**.h",
        "include/**.hpp",
        "include/**.inl",
        
        "contrib/unzip/**.h",
        "contrib/unzip/**.c",

        "contrib/irrXML/**.h",
        "contrib/irrXML/**.cpp",
        "contrib/pugixml/src/**.hpp",
        "contrib/pugixml/src/**.cpp",
        "contrib/utf8cpp/source/**.h",
        
        "contrib/openddlparser/code/**.cpp",
        "contrib/openddlparser/code/**.h",
    }

    removefiles
    {
        "code/Tests/**",
        "code/Pbrt/**",
        "test/**",
        "tools/**",
        "samples/**",

        "code/**/*Exporter.cpp",
        "code/**/*Exporter.h",
        "code/**/*Export*",
        
        "code/PostProcessing/*Exporter*",

        -- AGREGAR ESTO PARA SOLUCIONAR EL ERROR DE M3D Y OTROS:
        "code/**/M3DImporter.cpp",  -- Soluciona tu error actual
        "code/**/M3DImporter.h",
        
        -- Ya que tenés desactivados estos también en 'defines', te conviene sacarlos
        -- para evitar el mismo error con otros formatos:
        "code/**/C4DImporter.cpp", 
        "code/**/C4DImporter.h",
        "code/**/IFC*.cpp",
        "code/**/IFC*.h",
        "code/**/USD*.cpp", 
        "code/**/USD*.h",
        "code/**/X3DImporter*.cpp" -- VRML suele usar X3DImporter en Assimp moderno
    }

    externalincludedirs
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
        "ASSIMP_BUILD_NO_EXPORT",
        "ASSIMP_BUILD_NO_M3D_IMPORTER", 
        "ASSIMP_BUILD_NO_C4D_IMPORTER", 
        "ASSIMP_BUILD_NO_IFC_IMPORTER",
        "ASSIMP_BUILD_NO_USD_IMPORTER",
        "ASSIMP_BUILD_NO_VRML_IMPORTER",
        "_CRT_SECURE_NO_WARNINGS",
    }

    filter "system:linux"
        pic "On"
        systemversion "latest"

        removefiles
        {
            "contrib/zlib/contrib/minizip/iowin32.c",
            "contrib/zlib/contrib/minizip/iowin32.h",
            "contrib/zlib/contrib/testzlib/testzlib.c",
            "contrib/zlib/contrib/testzlib/testzlib.h"
        }

        links { "z" }

    filter "system:windows"
        systemversion "latest"
        defines { "WIN32_LEAN_AND_MEAN", "OPENDDL_STATIC_LIBARY", }

        files
        {
            "contrib/zlib/**.h",
            "contrib/zlib/**.c",
            "contrib/zlib/**.cpp",
        }

        removefiles
        {
            "contrib/zlib/contrib/**",
        }

    filter "system:macosx"
        systemversion "latest"
        pic "On"

        removefiles
        {
            "contrib/zlib/contrib/minizip/iowin32.c",
            "contrib/zlib/contrib/minizip/iowin32.h",
            "contrib/zlib/contrib/testzlib/testzlib.c",
            "contrib/zlib/contrib/testzlib/testzlib.h"
        }

        links { "z" }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
        runtime "Release"
        optimize "On"
