all: logic_op_dpi

logic_op_dpi:
	gcc -Wall -m64 -g -fPIC -I${VCS_HOME}/include ${VCS_HOME}/include/svdpi.h -shared -o logic_op_dpi.so \
		logic_op_dpi.c

