GO_SOURCES = $(wildcard *.go)

goas: $(GO_SOURCES)
	go build -o goas .

.PHONY: test
# Check /etc/os-release to prevent non-linux from running this
test:  /etc/os-release test-single test-babygo-test test-babygo-babygo

T1_SOURCES = $(wildcard t1/*.s)
T1_GNU_OBJS = $(T1_SOURCES:t1/%.s=out1/%.gnu.o)
T1_MY_OBJS = $(T1_SOURCES:t1/%.s=out1/%.my.o)

out1:
	mkdir -p $@

# Test single-source program
.PHONY: test-single
test-single: $(T1_GNU_OBJS) $(T1_MY_OBJS)
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
	@echo ok

out1/%.gnu.o: t1/%.s out1
	as -o $@ $<

out1/%.my.o: t1/%.s goas out1
	./goas -o $@ $<


# Test asm files generated by babygo's test
test-babygo-test: out2/my.o out2/gnu.o
	diff $^

out2:
	mkdir -p $@

out2/gnu.o: out2 t2/babygo-runtime.s t2/babygo-test.s
	as -o $@ t2/babygo-runtime.s t2/babygo-test.s

out2/my.o:  goas out2 t2/babygo-runtime.s t2/babygo-test.s
	./goas -o $@ t2/babygo-runtime.s t2/babygo-test.s


# Test asm files generated by babygo's self compiling
test-babygo-babygo: out3/my.o out3/gnu.o
	diff $^

out3:
	mkdir -p $@

out3/my.o: goas out3 t3/babygo-runtime.s t3/babygo-main.s
	./goas -o $@ t3/babygo-runtime.s t3/babygo-main.s

out3/gnu.o: out3 t3/babygo-runtime.s t3/babygo-main.s
	as -o $@ t3/babygo-runtime.s t3/babygo-main.s

# Make and run babygo
run-babygo-3: babygo-3
	./$< version

babygo-3: out3/my.o
	ld -o $@ $<

T4_SOURCES = $(wildcard t4/*.s)
T4_GNU_OBJS = $(T4_SOURCES:t4/%.s=out4/%.gnu.o)
T4_MY_OBJS = $(T4_SOURCES:t4/%.s=out4/%.my.o)

# Test asm files generated by babygo's test
test4: $(T4_GNU_OBJS) $(T4_MY_OBJS)
	./compare-obj out4
	@echo ok

out4:
	mkdir -p $@

out4/%.gnu.o: t4/%.s out4
	as -o $@ $<

out4/%.my.o: t4/%.s goas out4
	./goas -o $@ $<

# Make and run babygo
run-babygo-test: out4/babygo-test
	$<

out4/babygo-test: out4/*.my.o
	ld -o $@ $^

clean:
	rm -rf goas *.o *.bin *.out out1 out2 out3 out4 ./babygo
