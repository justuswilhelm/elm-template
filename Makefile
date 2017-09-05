.PHONY: all clean format reactor serve

SRC_PATH := src
STATIC_PATH := static
TEST_PATH := tests

ELM_FORMAT := elm-format-0.18
ELM_MAKE := elm-make
ELM_MAKE_FLAG := --warn --yes

BUILD := build
TARGET_JS := $(BUILD)/main.js
TARGET := $(TARGET_JS) $(BUILD)/index.html
SRC_JS := $(shell find $(SRC_PATH) -name '*.js')
SRC_ELM := $(shell find $(SRC_PATH) -name '*.elm')
TEST_ELM := $(wildcard $(TEST_PATH)/*.elm)
SRC := $(SRC_PATH)/Main.elm $(SRC_JS) $(SRC_ELM)

all: $(TARGET)

$(TARGET): $(BUILD)

$(BUILD):
	mkdir $@

$(BUILD)/main.js: $(SRC) $(BUILD)
	$(ELM_MAKE) $< --output $@ $(ELM_MAKE_FLAG)

$(BUILD)/%.html: %.html $(BUILD)
	cp $< $@

format: $(SRC_ELM) $(TEST_ELM)
	$(ELM_FORMAT) $^ --yes

install:
	elm package install --yes

clean:
	rm -rf elm-stuff/build-artifacts/
	rm -f $(TARGET)
	rm -rf $(BUILD)

live: $(SRC)
	elm-live \
		--output=$(STATIC_PATH)/main.js $< \
		--host=0.0.0.0 \
		--pushstate \
		--debug \
		--dir=$(STATIC_PATH)

check: $(SRC_ELM) $(TEST_ELM)
	$(ELM_FORMAT) $^ --validate || echo "Elm format not available"
	elm test

cloc:
	cloc --vcs=git
