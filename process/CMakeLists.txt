set(plasmoidplugin_SRCS
    plugin.cpp
    process.cpp
    )

find_package(KF5KIO)

add_library(plasmoidplugin SHARED ${plasmoidplugin_SRCS})

target_link_libraries(plasmoidplugin Qt5::Quick KF5::Plasma KF5::KIOCore KF5::KIOFileWidgets KF5::KIOWidgets KF5::KIONTLM)

install(TARGETS plasmoidplugin DESTINATION ${QML_INSTALL_DIR}/eu/naraesk/docker/process)

install(FILES qmldir DESTINATION ${QML_INSTALL_DIR}/eu/naraesk/docker/process)
