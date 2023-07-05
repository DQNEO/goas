GOSOURCES = $(wildcard *.go)
SOURCES = $(wildcard t1/*.s)
GNU_OBJS = $(SOURCES:t1/%.s=out1/%.gnu.o)
MY_OBJS = $(SOURCES:t1/%.s=out1/%.my.o)

goas: $(GOSOURCES)
	go build -o goas .

.PHONY: test
test: test-single test-multi

out1:
	mkdir -p $@

# Test single-source program
.PHONY: test-single
test-single: $(GNU_OBJS) $(MY_OBJS)
	diff out1/00.gnu.o out1/00.my.o
	diff out1/01.gnu.o out1/01.my.o
	diff out1/02.gnu.o out1/02.my.o
	diff out1/03.gnu.o out1/03.my.o
	diff out1/04.gnu.o out1/04.my.o
	diff out1/05.gnu.o out1/05.my.o
	diff out1/06.gnu.o out1/06.my.o
	diff out1/07.gnu.o out1/07.my.o
	diff out1/08.gnu.o out1/08.my.o
	diff out1/09.gnu.o out1/09.my.o
	diff out1/10.gnu.o out1/10.my.o
	@echo ok

out1/%.gnu.o: t1/%.s out1
	as -o $@ $<

out1/%.my.o: t1/%.s goas out1
	./goas -o $@ $<

# Test multi-source program
.PHONY: test-multi test-babygo-test test-babygo-self
test-multi: test-babygo-test test-babygo-self

out2:
	mkdir -p $@

test-babygo-test: out2/t.my.o out2/t.gnu.o
	diff $^

out2/t.gnu.o: t2/babygo-runtime.s t2/babygo-test.s
	as -o $@ $^

out2/t.my.o:  goas t2/babygo-runtime.s t2/babygo-test.s out2
	./goas -o $@ t2/babygo-runtime.s t2/babygo-test.s

test-babygo-self: out2/b.my.o out2/b.gnu.o
	diff $^

out2/b.my.o: goas t2/babygo-runtime.s t2/babygo-main.s
	./goas -o $@ t2/babygo-runtime.s t2/babygo-main.s

out2/b.gnu.o: t2/babygo-runtime.s t2/babygo-main.s
	as -o $@ $^

# Make binary executables (These are not essential)
out2/t.gnu.bin: t2/t.gnu.o
	ld -o $@ $<

out2/t.my.bin: t2/t.my.o
	ld -o $@ $<

babygo: out2/b.my.o
	ld -o $@ $<
	./$@ version

clean:
	rm -f goas *.{o,bin,out} out{1,2}/*.{o,bin}
