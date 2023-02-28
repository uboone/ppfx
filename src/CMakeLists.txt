

FILE( GLOB cxx_files *.cpp )


art_make_library(LIBRARY_NAME ppfx
                 SOURCE       ${cxx_files}
                 LIBRARIES    dk2nu::Tree
                              ${ROOT_BASIC_LIB_LIST}
                              ${ROOT_EG}

         
)


install_source()
