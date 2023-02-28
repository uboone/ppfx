# ======================================================================
#  ppfx main build file
#
#  cd .../path/to/build/directory
#  source .../path/to/ppfx/ups/setup_for_development
#  cmake [-DCMAKE_INSTALL_PREFIX=/install/path]
#        -DCMAKE_BUILD_TYPE=$CETPKG_TYPE
#        $CETPKG_SOURCE
#
#  make
#  make test
#  make install
#  make package (builds distribution tarfile)
# ======================================================================


cmake_minimum_required(VERSION 3.20 FATAL_ERROR)

find_package(cetmodules REQUIRED)
project(ppfx VERSION 02.16.00 LANGUAGES CXX)

# cetbuildtools contains our cmake modules

include(CetCMakeEnv)
cet_cmake_env()

cet_set_compiler_flags(DIAGS CAUTIOUS WERROR
                       NO_UNDEFINED
                       EXTRA_FLAGS -pedantic
                       EXTRA_CXX_FLAGS -Wno-unused-local-typedefs -Wno-variadic-macros)
cet_report_compiler_flags(REPORT_THRESHOLD VERBOSE)

find_package(nufinder REQUIRED EXPORT)

find_package( art        REQUIRED )
find_package( genie      REQUIRED )
find_package( dk2nudata  REQUIRED )
find_package( dk2nugenie REQUIRED )
find_package( fftw       REQUIRED )
find_package( libwda     REQUIRED )
find_package( postgresql REQUIRED )
find_package(  Boost REQUIRED )
find_package( ROOT REQUIRED )

message(STATUS "ROOTSYS is ${ROOTSYS}")

## find_library directives
# other dependencies
cet_find_library( PYTHIA6 NAMES Pythia6 PATHS ENV PYLIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( LHAPDF NAMES LHAPDF PATHS ENV LHAPDF_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( LOG4CPP NAMES log4cpp PATHS ENV LOG4CPP_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( XML2 NAMES xml2 PATHS $ENV{LIBXML2_FQ_DIR}/lib NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
# genie
cet_find_library( GALGORITHM NAMES GAlgorithm PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GBARYONRESONANCE NAMES GBaryonResonance PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GBASE NAMES GBase PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GBODEKYANG NAMES GBodekYang PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GCHARM NAMES GCharm PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GCOH NAMES GCoh PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GDFRC NAMES GDfrc PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GDIS NAMES GDIS PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GCROSSSECTIONS NAMES GCrossSections PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GDECAY NAMES GDecay PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GELAS NAMES GElas PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GELFF NAMES GElFF PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GHEP NAMES GHEP PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GEVGCORE NAMES GEVGCore  PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GEVGMODULES NAMES GEVGModules PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GEVGDRIVERS NAMES GEVGDrivers PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GGIBUU NAMES GGiBUU PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GHADRONTRANSP NAMES GHadronTransp PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GFRAGMENTATION NAMES GFragmentation PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GINTERACTION NAMES GInteraction PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GLLEWELLYNSMITH NAMES GLlewellynSmith  PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GMEC NAMES GMEC PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GMESSENGER NAMES GMessenger PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GNUGAMMA NAMES GNuGamma PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GNUE NAMES GNuE PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GNTUPLE NAMES GNtuple PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GNUCLEAR NAMES GNuclear PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GNUMERICAL NAMES GNumerical PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GQPM NAMES GQPM PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GPDG NAMES GPDG PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GPDF NAMES GPDF PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GQEL NAMES GQEL PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GRES NAMES GRES PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GREGISTRY NAMES GRegistry PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility

# prior to GENIE R-2_9_0 Sehgal's name was spelled incorrectly
# so if minor version # is 8 or less use GReinSeghal, otherwise GReinSehgal
# parse_ups_version returns VMAJ, VMIN, and VPRJ
parse_ups_version( ${GENIE_VERSION} )
set ( GRSSPELLING GReinSehgal )
if ( ${VMAJ} EQUAL 2 AND ${VMIN} LESS 9 )
  set ( GRSSPELLING GReinSeghal )
endif ( ${VMAJ} EQUAL 2 AND ${VMIN} LESS 9 )
message(STATUS "GENIE version ${GENIE_VERSION} major ${VMAJ} minor ${VMIN} ${GRSSPELLING}")
cet_find_library( GREINSEHGAL NAMES ${GRSSPELLING} PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility

cet_find_library( GUTILS NAMES GUtils PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GGEO NAMES GGeo PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GFLUXDRIVERS NAMES GFluxDrivers PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GMUELOSS NAMES GMuELoss PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GREWEIGHT NAMES GReWeight PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( GNUCLEONDECAY NAMES GNucleonDecay PATHS ENV GENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility

set(GENIE_LIB_LIST  ${GALGORITHM}
                    ${GBARYONRESONANCE}
                    ${GBASE}
                    ${GBODEKYANG}
                    ${GCHARM}
                    ${GCOH}
                    ${GDFRC}
                    ${GDIS}
                    ${GCROSSSECTIONS}
                    ${GDECAY}
                    ${GELAS}
                    ${GELFF}
                    ${GHEP}
                    ${GEVGCORE}
                    ${GEVGMODULES}
                    ${GEVGDRIVERS}
                    ${GGIBUU}
                    ${GHADRONTRANSP}
                    ${GFRAGMENTATION}
                    ${GINTERACTION}
                    ${GLLEWELLYNSMITH}
                    ${GMEC}
                    ${GMESSENGER}
                    ${GNUGAMMA}
                    ${GNUE}
                    ${GNTUPLE}
                    ${GNUCLEAR}
                    ${GNUMERICAL}
                    ${GQPM}
                    ${GPDG}
                    ${GPDF}
                    ${GQEL}
                    ${GRES}
                    ${GREGISTRY}
                    ${GREINSEHGAL}
                    ${GUTILS}
                    ${GGEO}
                    ${GFLUXDRIVERS}
                    ${GMUELOSS}
                    ${GREWEIGHT}
                    ${GNUCLEONDECAY}
                    )

# dk2nu
cet_find_library( DK2NU_TREE  NAMES dk2nuTree  PATHS ENV DK2NUDATA_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
cet_find_library( DK2NU_GENIE NAMES dk2nuGenie PATHS ENV DK2NUGENIE_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
include_directories( $ENV{DK2NUDATA_INC} $ENV{DK2NUGENIE_INC} ) ### MIGRATE-ACTION-RECOMMENDED (migrate-3.20.00) - avoid directory-scope functions: use target_link_libraries() with target semantics or target_include_directories() whenever possible

# ifdhc
cet_find_library( IFDH NAMES ifdh PATHS ENV IFDHC_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
include_directories( $ENV{IFDHC_FQ_DIR}/inc ) ### MIGRATE-ACTION-RECOMMENDED (migrate-3.20.00) - avoid directory-scope functions: use target_link_libraries() with target semantics or target_include_directories() whenever possible

# ifdhc_art  # as a service
cet_find_library( IFDH_SERVICE NAMES IFDH_service PATHS ENV IFDH_ART_LIB NO_DEFAULT_PATH ) ### MIGRATE-ACTION-REQUIRED (migrate-3.20.00) - avoid: use find_package() with custom Find<pkg>.cmake for Spack compatibility
include_directories( $ENV{IFDH_ART_FQ_DIR}/inc ) ### MIGRATE-ACTION-RECOMMENDED (migrate-3.20.00) - avoid directory-scope functions: use target_link_libraries() with target semantics or target_include_directories() whenever possible

# macros
include(ArtMake)
include(BuildPlugins)
include(CetRootCint)

# include search path
include_directories ( $ENV{GENIE_INC}/GENIE ) ### MIGRATE-ACTION-RECOMMENDED (migrate-3.20.00) - avoid directory-scope functions: use target_link_libraries() with target semantics or target_include_directories() whenever possible
include_directories ( $ENV{LIBXML2_INC} ) ### MIGRATE-ACTION-RECOMMENDED (migrate-3.20.00) - avoid directory-scope functions: use target_link_libraries() with target semantics or target_include_directories() whenever possible
include_directories ( $ENV{G4INCLUDE} ) ### MIGRATE-ACTION-RECOMMENDED (migrate-3.20.00) - avoid directory-scope functions: use target_link_libraries() with target semantics or target_include_directories() whenever possible
include_directories ( $ENV{XERCES_C_INC} ) ### MIGRATE-ACTION-RECOMMENDED (migrate-3.20.00) - avoid directory-scope functions: use target_link_libraries() with target semantics or target_include_directories() whenever possible
include_directories ( $ENV{CRYHOME}/src ) ### MIGRATE-ACTION-RECOMMENDED (migrate-3.20.00) - avoid directory-scope functions: use target_link_libraries() with target semantics or target_include_directories() whenever possible
include_directories ( $ENV{LOG4CPP_INC} ) ### MIGRATE-ACTION-RECOMMENDED (migrate-3.20.00) - avoid directory-scope functions: use target_link_libraries() with target semantics or target_include_directories() whenever possible

# included for Mac OSX using XQuartz for X11
if(APPLE)
  include_directories ( /opt/X11/include ) ### MIGRATE-ACTION-RECOMMENDED (migrate-3.20.00) - avoid directory-scope functions: use target_link_libraries() with target semantics or target_include_directories() whenever possible
endif()

# source
include_directories( ${CMAKE_CURRENT_SOURCE_DIR}/include ) ### MIGRATE-ACTION-RECOMMENDED (migrate-3.20.00) - avoid directory-scope functions: use target_link_libraries() with target semantics or target_include_directories() whenever possible
add_subdirectory (src)
add_subdirectory (include)
add_subdirectory (data)
add_subdirectory (scripts)
add_subdirectory (uncertainties)

# ups - table and config files

# packaging utility

cet_cmake_config()
