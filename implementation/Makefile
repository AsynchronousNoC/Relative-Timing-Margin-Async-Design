SETUP_SCRIPT = ../.setup_tools
CFG = cadence_syn
GUI = 1 
DEBUG = 0
FLOW_STEP = syn_opt
FLOW=rtl2gds.express_async
VER=""



DEBUG_FLAGS= ""
TARGET_DIR = $(TOP_DESIGN)
VERILOG_FLAGS ="" 
FLOW_NAME = $(FLOW)


help:
	@echo "make [vsim|spyglass|genus|innovus] [GUI=1]"
setup: ../.setup_tools
	@if [ "$(LOGICAL_PATH)" = "" ]; then echo "ERROR: Design not set up";exit 1;else echo "LOGICAL_PATH=$(LOGICAL_PATH)"; fi


$(IMPLEMENTATION_DIR)/$(TARGET_DIR)/modelsim/$(TOP_DESIGN).work/@_opt: setup $(LOGICAL_PATH)/$(TOP_DESIGN)_testbench.vc
	echo "Compile Modelsim RTL simulation - ";\
	module load questa/2025.3;\
	export rundir=$(IMPLEMENTATION_DIR)/$(TARGET_DIR)/modelsim;\
	mkdir -p $${rundir}/logs  ;\
	flags="$(VERILOG_FLAGS) $(DEBUG_FLAGS)"; \
	if [ $(FUNCTIONAL) -eq 1 ];then flags="$$flags +define+FUNCTIONAL_MATHS"; fi; \
	vlog  -sv +define+debug=$(DEBUG) $$flags +incdir+. -f $(LOGICAL_PATH)/$(TOP_DESIGN).vc -f $(LOGICAL_PATH)/$(TOP_DESIGN)_testbench.vc -work $${rundir}/$(TOP_DESIGN).work -l $${rundir}/logs/$(TOP_DESIGN)_compile.log


vsim:  setup $(IMPLEMENTATION_DIR)/$(TARGET_DIR)/modelsim/$(TOP_DESIGN).work/@_opt
	@echo "Run Modelsim RTL simulation - ";\
	module load questa/2025.3;\
	rundir=$(IMPLEMENTATION_DIR)/$(TARGET_DIR)/modelsim;\
	echo "Run dir: $${rundir}";\
	mkdir -p $$rundir/logs ;\
	echo "GUI: $(GUI)";\
	if [ $(GUI) -eq 0 ]; then \
	vsim -quiet $(TOP_DESIGN)_tb -warning 7033 -l  $${rundir}/logs/$(TOP_DESIGN).log -work  $${rundir}/${TOP_DESIGN}.work +notimingchecks  -c -do "run -a;exit" ;\
	else \
	DO="";\
	if [ -f $(TOP_DESIGN).do ]; then  DO="source $(TOP_DESIGN).do"; else  if [ -f wave.do ];then  DO="source wave.do"; fi;fi;\
	vsim -quiet $(TOP_DESIGN)_tb -warning 7033 -l  $${rundir}/logs/$(TOP_DESIGN).log -work  $${rundir}/${TOP_DESIGN}.work +notimingchecks -voptargs=+acc -do "log -r *;  $$DO" ;\
	fi
xrun: 
	@echo "Run Cadence RTL simulation - ";\
	rundir=$(IMPLEMENTATION_DIR)//$(TARGET_DIR)/xcelium;\
	mkdir -p $${rundir}/logs ;\
	module load cadence/xcelium/23.03;\
	if [ $(GUI) -eq 0 ]; then \
	xrun -sysv $(VERILOG_FLAGS) -f $(LOGICAL_PATH)/$(TOP_DESIGN)_testbench.vc -f $(LOGICAL_PATH)/$(TOP_DESIGN).vc  \
	  -l $${rundir}/logs/$(TOP_DESIGN).log +notimingchecks \
	  -xmlibdirname $${rundir}/logs/$(TOP_DESIGN).d;\
	else \
	xrun -sysv -gui $(VERILOG_FLAGS) -f $(LOGICAL_PATH)/$(TOP_DESIGN).vc -f $(LOGICAL_PATH)/$(TOP_DESIGN)_testbench.vc  \
		-l $${rundir}/logs/$(TOP_DESIGN).log +notimingchecks \
		-xmlibdirname $${rundir}/logs/$(TOP_DESIGN).d  -access +rwc;\
	fi

vcs: $(LOGICAL_PATH)/$(TOP_DESIGN)_testbench.vc
	@echo "Run VCS RTL simulation -";\
	module load synopsys/vcs/U-2023.03-SP1-1;\
	rundir=$(IMPLEMENTATION_DIR)/$(TARGET_DIR)/vcs;\
	echo "Run dir: $${rundir}";\
	mkdir -p $${rundir}/logs ;\
	if  [ $(GUI) -eq 0 ]; then \
		CGUI_FLAG="";RGUI_FLAG="";\
	else \
		CGUI_FLAG="-debug_access+all";RGUI_FLAG=" -verdi";\
	fi;\
	flags="$(VERILOG_FLAGS) $(DEBUG_FLAGS)"; \
   echo "Generating $${rundir}/$(TOP_DESIGN)_tb";\
	vcs -full64 -kdb -lca -sverilog -timescale=1ns/1ps -assert svaext -debug_access+all +notimingchecks $$CGUI_FLAG  $$flags\
		$(VERILOG_FLAGS) -f $(LOGICAL_PATH)/$(TOP_DESIGN).vc  -f $(LOGICAL_PATH)/$(TOP_DESIGN)_testbench.vc -o $${rundir}/$(TOP_DESIGN)_tb >$${rundir}/logs/$(TOP_DESIGN)_vcs.log;\
	cp *_hex.txt $${rundir};\
	$${rundir}/$(TOP_DESIGN)_tb $$RGUI_FLAG;\


clean:
	@cd $(IMPLEMENTATION_DIR)/$(TARGET_DIR)
	\rm -Rf synopsys cadence modelsim work *.log* *.cmd* schedu* wlf* *.wlf
