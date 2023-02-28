

FILE( GLOB cxx_files *.cpp )

cet_find_library( DK2NUTREE  NAMES dk2nuTree  PATHS ENV DK2NUDATA_LIB ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility

art_make_library(LIBRARY_NAME ppfx
                 SOURCE       ${cxx_files}
                 LIBRARIES    dk2nuTree
                              ${ROOT_BASIC_LIB_LIST}
                              ${ROOT_EG}

         
)


install_source()
