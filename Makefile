GOSOURCES = $(wildcard *.go)
SOURCES = $(wildcard t1/*.s)
GNU_OBJS = $(SOURCES:t1/%.s=t1/%.gnu.o)
MY_OBJS = $(SOURCES:t1/%.s=t1/%.my.o)

.PHONY: test
test: test-single test-multi

goas: $(GOSOURCES)
	go build

# Test single-source program
.PHONY: test-single
test-single: objs
	diff t1/00.gnu.o t1/00.my.o
	diff t1/01.gnu.o t1/01.my.o
	diff t1/02.gnu.o t1/02.my.o
	diff t1/03.gnu.o t1/03.my.o
	diff t1/04.gnu.o t1/04.my.o
	diff t1/05.gnu.o t1/05.my.o
	diff t1/06.gnu.o t1/06.my.o
	diff t1/07.gnu.o t1/07.my.o
	diff t1/08.gnu.o t1/08.my.o
	diff t1/09.gnu.o t1/09.my.o
	diff t1/10.gnu.o t1/10.my.o
	@echo ok

.PHONY: objs
objs: $(GNU_OBJS) $(MY_OBJS)

t1/%.gnu.o: t1/%.s
	as -o $@ $<

t1/%.my.o: t1/%.s goas
	./goas -o $@ $<

# Test multi-source program
.PHONY: test-multi test-babygo-test test-babygo-self
test-multi: test-babygo-test test-babygo-self

test-babygo-test: t2/t.my.o t2/t.gnu.o
	diff $^

t2/t.gnu.o: t2/babygo-runtime.s t2/babygo-test.s
	as -o $@ $^

t2/t.my.o:  goas t2/babygo-runtime.s t2/babygo-test.s
	./goas -o $@ t2/babygo-runtime.s t2/babygo-test.s

test-babygo-self: t2/b.my.o t2/b.gnu.o
	diff $^

t2/b.my.o: goas t2/babygo-runtime.s t2/babygo-main.s
	./goas -o $@ t2/babygo-runtime.s t2/babygo-main.s

t2/b.gnu.o: t2/babygo-runtime.s t2/babygo-main.s
	as -o $@ $^

# Make binary executables (These are not essential)
t2/t.gnu.bin: t2/t.gnu.o
	ld -o $@ $<

t2/t.my.bin: t2/t.my.o
	ld -o $@ $<

babygo: t2/b.my.o
	ld -o $@ $<
	./$@ version

clean:
	rm -f *.o goas t1/*.o t1/*.bin t2/*.o t2/*.bin babygo a.out
