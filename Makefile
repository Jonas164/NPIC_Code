# Variables
NIMC = nim
NIM_FILES := $(wildcard *.nim)
C_OUT_DIR = build/c
CPP_OUT_DIR = build/cpp
JS_OUT_DIR = build/js
OBJC_OUT_DIR = build/objectivec

# Create output directories if they don't exist
.PHONY: dirs
dirs:
	mkdir -p $(C_OUT_DIR) $(CPP_OUT_DIR) $(JS_OUT_DIR) $(OBJC_OUT_DIR)

# Rule to compile .nim files to C
$(C_OUT_DIR)/%.c: %.nim | dirs
	$(NIMC) c --nimcache:$(C_OUT_DIR)/.nimcache $<

#Rule to compile .nim files to C++
$(CPP_OUT_DIR)/%.cpp: %.nim | dirs
	$(NIMC) cpp --nimcache:$(CPP_OUT_DIR)/.nimcache $<

# Rule to compile .nim files to JavaScript
$(JS_OUT_DIR)/%.js: %.nim | dirs
	$(NIMC) js --nimcache:$(JS_OUT_DIR)/.nimcache $<

# Rule to compile .nim files to  Objective-C
$(OBJC_OUT_DIR)/%.ll: %.nim | dirs
	$(NIMC) objc --nimcache:$(OBJC_OUT_DIR)/.nimcache $<

.PHONY: js
js: $(patsubst %.nim,$(JS_OUT_DIR)/%.js,$(NIM_FILES))

.PHONY: cpp
cpp:  $(patsubst %.nim,$(CPP_OUT_DIR)/%.cpp,$(NIM_FILES)) \

.PHONY: objc
objc:  $(patsubst %.nim,$(OBJC_OUT_DIR)/%.ll,$(NIM_FILES)) \

# Compile all files to each target
.PHONY: all
all: $(patsubst %.nim,$(C_OUT_DIR)/%.c,$(NIM_FILES)) \
     $(patsubst %.nim,$(CPP_OUT_DIR)/%.cpp,$(NIM_FILES)) \
	 $(patsubst %.nim,$(OBJC_OUT_DIR)/%.ll,$(NIM_FILES)) \
     $(patsubst %.nim,$(JS_OUT_DIR)/%.js,$(NIM_FILES)) 

# Clean up all generated files
.PHONY: clean
clean:
	rm -rf build
