name := matt
ver  := 0

objs := lib$(name).o

GCC  = gcc -Wall -O2 -fPIC

all: lib$(name).so lib$(name).a

%.o: %.c $(name).h Makefile
	$(GCC) -c $<

%.so: $(objs)
	$(GCC) -shared -Wl,-soname,$@.$(ver) $^ -o $@

%.a: $(objs)
	ar -cvr $@ $^

install: all
	install -m0755 -d $(DESTDIR)/usr/local/{include,lib}/
	install -m0644    lib$(name).a    $(DESTDIR)/usr/local/lib/
	install -m0755 -T lib$(name).so   $(DESTDIR)/usr/local/lib/lib$(name).so.$(ver)
	install -m0644    $(name).h       $(DESTDIR)/usr/local/include
	ln -sf            lib$(name).so.$(ver) $(DESTDIR)/usr/local/lib/lib$(name).so

clean:
	$(RM) $(objs) lib$(name).so lib$(name).a

