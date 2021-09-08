GOSOURCES = $(wildcard *.go)
SOURCES = $(wildcard t/*.s)
GNU_OBJS = $(SOURCES:t/%.s=t/%.gnu.o)
MY_OBJS = $(SOURCES:t/%.s=t/%.my.o)

.PHONY: test
test: test-single test-multi

goas: $(GOSOURCES)
	go build

# Test single-source program
.PHONY: test-single
test-single: objs
	diff t/00.gnu.o t/00.my.o
	diff t/01.gnu.o t/01.my.o
	diff t/02.gnu.o t/02.my.o
	diff t/03.gnu.o t/03.my.o
	diff t/04.gnu.o t/04.my.o
	diff t/05.gnu.o t/05.my.o
	diff t/06.gnu.o t/06.my.o
	diff t/07.gnu.o t/07.my.o
	diff t/08.gnu.o t/08.my.o
	diff t/10.gnu.o t/10.my.o
	@echo ok

.PHONY: objs
objs: $(GNU_OBJS) $(MY_OBJS)

t/%.gnu.o: t/%.s
	as -o $@ $<

t/%.my.o: t/%.s goas
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
	ld -e _rt0_amd64_linux -o $@ $<

t2/t.my.bin: t2/t.my.o
	ld -e _rt0_amd64_linux -o $@ $<

babygo: t2/b.my.o
	ld -e _rt0_amd64_linux -o $@ $<
	./$@ version

clean:
	rm -f goas t/*.o t/*.bin t2/*.o t2/*.bin babygo a.out
