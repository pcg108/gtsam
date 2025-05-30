###############################################################################
# Find TBB
if (GTSAM_WITH_TBB)
    find_package(TBB 4.4 COMPONENTS tbb tbbmalloc)
endif()

# Set up variables if we're using TBB
if(TBB_FOUND AND GTSAM_WITH_TBB)
    set(GTSAM_USE_TBB 1)  # This will go into config.h
    if ((${TBB_VERSION_MAJOR} GREATER 2020) OR (${TBB_VERSION_MAJOR} EQUAL 2020))
        set(TBB_GREATER_EQUAL_2020 1)
    else()
        set(TBB_GREATER_EQUAL_2020 0)
    endif()
    # all definitions and link requisites will go via imported targets:
    # tbb & tbbmalloc
    list(APPEND GTSAM_ADDITIONAL_LIBRARIES tbb tbbmalloc)
else()
    set(GTSAM_USE_TBB 0)  # This will go into config.h
endif()

###############################################################################
# Prohibit Timing build mode in combination with TBB
if(GTSAM_USE_TBB AND (CMAKE_BUILD_TYPE  STREQUAL "Timing"))
      message(FATAL_ERROR "Timing build mode cannot be used together with TBB. Use a sampling profiler such as Instruments or Intel VTune Amplifier instead.")
endif()
