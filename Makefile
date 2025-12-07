FC=f77
FD=f77
OEXT=.o
EEXT=
RM=rm -rf
FFLAGS=
FDFLAGS=
LIBS=
SRCS=sales1.f sales2.f th1.f th2.f surv.f create_surv_data.f

OBJS = $(SRCS:.f=$(OEXT))
TARGETS = $(OBJS:$(OEXT)=$(EEXT))
.PHONY: all clean

all: $(OBJS) $(TARGETS)

%$(OEXT): %.f
	$(FC) -c $(FFLAGS) -o $@ $<

%$(EEXT): %$(OEXT)
	$(FD) -o $@ $^ $(FDFLAGS) $(LIBS)

clean:
	$(RM) $(OBJS) $(TARGETS)

