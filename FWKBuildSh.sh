# define output folder environment variable
LIB_TARGET_NAME=${PROJECT_NAME}

UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-universal

OUTPUT_DIR=${UNIVERSAL_OUTPUTFOLDER}

# Step 1. Build Device and Simulator versions
xcodebuild -target ${LIB_TARGET_NAME} ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}"
xcodebuild  -target ${LIB_TARGET_NAME} -arch x86_64 -sdk iphonesimulator -configuration ${CONFIGURATION} BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}"


# make sure the output directory exists
mkdir -p ${UNIVERSAL_OUTPUTFOLDER}

# Step 2. Create universal binary file using lipo
lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/lib${PROJECT_NAME}.a" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/lib${PROJECT_NAME}.a" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/lib${PROJECT_NAME}.a"
# Last touch. copy the header files. Just for convenience

mkdir -p ${OUTPUT_DIR}

cp -v -f -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/include" "${OUTPUT_DIR}"

open UNIVERSAL_OUTPUTFOLDER
