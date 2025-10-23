IVERILOG ?= iverilog
VVP ?= vvp
TOP ?= mutex_tb
VLIST ?= vlist.txt
BUILD_DIR ?= build
SIM ?= $(BUILD_DIR)/$(TOP).vvp
VFLAGS ?= -g2005

ifeq ($(VCD),1)
VFLAGS += -D VCD=1
endif

SRC := $(shell cat $(VLIST))

.PHONY: all build run clean

all: run

build: $(SIM)

run: $(SIM)
	$(VVP) $(SIM)

$(SIM): $(SRC) $(VLIST)
	@mkdir -p $(BUILD_DIR)
	$(IVERILOG) $(VFLAGS) -o $@ -c $(VLIST)

clean:
	rm -rf $(BUILD_DIR)
