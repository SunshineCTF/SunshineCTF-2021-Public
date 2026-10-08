TARGET := garble

# libpng-dev is installed by prebuild.sh in this directory
LDLIBS := -lpng

BITS := 64
ASLR := 1
NX := 1
RELRO := 1
# CANARY := 1
STRIP := 1

GARBLE_DIR := $(DIR)
GARBLE_BUILD := $(BUILD_DIR)
# Capture the garble executable path now; $(TARGET) is a shared variable that
# gets reused by other projects, so it would be wrong by the time these recipes run.
GARBLE_EXE := $(BUILD_DIR)/$(TARGET)

# Convert each PNG in this project directory to a GRB
GARBLE_IMAGES := $(patsubst $(DIR)/%,%,$(wildcard $(DIR)/*.png))

# Garble an input PNG file into *.grb
$(GARBLE_BUILD)/%.grb: $(GARBLE_DIR)/%.png $(GARBLE_EXE)
	$(_V)echo 'Garbling $< into $@'
	$(_v)$(GARBLE_EXE) $< > $@

# Add the executable and all garbled images to an archive, stored at the top
# level of the archive rather than under the build directory path
GARBLE_ARCHIVE_NAME := recovered.tar.gz
GARBLE_ARCHIVE_FILES := $(GARBLE_EXE) $(addprefix $(GARBLE_BUILD)/,$(GARBLE_IMAGES:.png=.grb))
$(GARBLE_BUILD)/$(GARBLE_ARCHIVE_NAME): $(GARBLE_ARCHIVE_FILES)
	$(_V)echo 'Archiving $@'
	$(_v)tar czvf $@ -C $(@D) $(^F)

PUBLISH_BUILD := $(GARBLE_ARCHIVE_NAME)
