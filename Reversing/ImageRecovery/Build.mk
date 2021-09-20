TARGET := garble
LDLIBS := -lpng

BITS := 64
ASLR := 1
DEP := 1
RELRO := 1
# CANARY := 1
STRIP := 1

GARBLE_DIR := $(DIR)
GARBLE_BUILD := $(BUILD_DIR)

# Convert each PNG in this project directory to a GRB
GARBLE_IMAGES := $(patsubst $(DIR)/%,%,$(wildcard $(DIR)/*.png))

# Garble an input PNG file into *.grb
$(GARBLE_BUILD)/%.grb: $(GARBLE_DIR)/%.png $(GARBLE_BUILD)/$(TARGET)
	$(_V)echo 'Garbling $< into $@'
	$(_v)$(GARBLE_BUILD)/$(TARGET) $< > $@

# Add the executable and all garbled images to an archive
GARBLE_ARCHIVE_NAME := recovered.tar.gz
GARBLE_ARCHIVE_FILES := $(addprefix $(GARBLE_BUILD)/,$(TARGET) $(GARBLE_IMAGES:.png=.grb))
$(GARBLE_BUILD)/$(GARBLE_ARCHIVE_NAME): $(GARBLE_ARCHIVE_FILES)
	$(_V)echo 'Archiving $@'
	$(_v)tar czvf $@ $^

PUBLISH_BUILD := $(GARBLE_ARCHIVE_NAME)
