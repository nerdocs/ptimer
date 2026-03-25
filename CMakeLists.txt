cmake_minimum_required(VERSION 3.16)

project(ptimer)

set(QT_MIN_VERSION "5.15.0")
set(KF_MIN_VERSION "5.82.0")

find_package(ECM ${KF_MIN_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(FeatureSummary)

# Install the Plasma widget package
plasma_install_package(package org.nerdocs.ptimer)

# Install translations
if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/po)
    ki18n_install(po)
endif()

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
