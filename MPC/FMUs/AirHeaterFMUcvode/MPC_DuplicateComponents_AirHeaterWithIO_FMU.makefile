# FIXME: before you push into master...
RUNTIMEDIR=C:/Program Files/OpenModelica1.21.0-dev-64bit/include/omc/c/
#COPY_RUNTIMEFILES=$(FMI_ME_OBJS:%= && (OMCFILE=% && cp $(RUNTIMEDIR)/$$OMCFILE.c $$OMCFILE.c))

fmu:
	rm -f MPC_DuplicateComponents_AirHeaterWithIO.fmutmp/sources/MPC_DuplicateComponents_AirHeaterWithIO_init.xml
	cp -a "C:/Program Files/OpenModelica1.21.0-dev-64bit/share/omc/runtime/c/fmi/buildproject/"* MPC_DuplicateComponents_AirHeaterWithIO.fmutmp/sources
	cp -a MPC_DuplicateComponents_AirHeaterWithIO_FMU.libs MPC_DuplicateComponents_AirHeaterWithIO.fmutmp/sources/

