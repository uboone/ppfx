file(GLOB xml_files *.xml)
install( FILES ${xml_files} DESTINATION data/MIPP )

file(GLOB root_files *.root)
install( FILES ${root_files} DESTINATION data/MIPP )
