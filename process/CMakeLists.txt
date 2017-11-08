set(plasmoidplugin_SRCS
    plugin.cpp
    process.cpp
    )

add_library(plasmoidplugin SHARED ${plasmoidplugin_SRCS})

target_link_libraries(plasmoidplugin Qt5::Quick KF5::Plasma)

install(TARGETS plasmoidplugin DESTINATION ${QML_INSTALL_DIR}/eu/naraesk/docker/process)

install(FILES qmldir DESTINATION ${QML_INSTALL_DIR}/eu/naraesk/docker/process)
