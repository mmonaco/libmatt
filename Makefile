name   := matt
ver    := 0
objs   := lib$(name).o
prefix := /usr/local

GCC  = gcc -Wall -O2

all: lib$(name).so lib$(name).a

%.o: %.c $(name).h Makefile
	$(GCC) -fPIC -c $<

%.so: $(objs)
	$(GCC) -fPIC -shared -Wl,-soname,$@.$(ver) $^ -o $@

%.a: $(objs)
	ar -cvr $@ $^

install: all
	install -m0755 -d $(DESTDIR)/$(prefix)/{include,lib}/
	install -m0644    lib$(name).a    $(DESTDIR)/$(prefix)/lib/
	install -m0755 -T lib$(name).so   $(DESTDIR)/$(prefix)/lib/lib$(name).so.$(ver)
	install -m0644    $(name).h       $(DESTDIR)/$(prefix)/include
	ln -sf            lib$(name).so.$(ver) $(DESTDIR)/$(prefix)/lib/lib$(name).so

clean:
	$(RM) $(objs) lib$(name).so lib$(name).a

