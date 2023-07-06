GO_SOURCES = $(wildcard *.go)

goas: $(GO_SOURCES)
	go build -o goas .

.PHONY: test
# Check /etc/os-release to prevent non-linux from running this
test:  /etc/os-release test1 test2 test3 test4

T1_SOURCES = $(wildcard t1/*.s)
T1_GNU_OBJS = $(T1_SOURCES:t1/%.s=out1/%.gnu.o)
T1_MY_OBJS = $(T1_SOURCES:t1/%.s=out1/%.my.o)

out1:
	mkdir -p $@

# Test single-source program
.PHONY: test1
test1: $(T1_GNU_OBJS) $(T1_MY_OBJS)
	./tool/compare-obj out1
	@echo ok

out1/%.gnu.o: t1/%.s out1
	as -o $@ $<

out1/%.my.o: t1/%.s goas out1
	./goas -o $@ $<


# Test asm files generated by babygo's test
test2: out2/my.o out2/gnu.o
	diff $^

out2:
	mkdir -p $@

out2/gnu.o: out2 t2/babygo-runtime.s t2/babygo-test.s
	as -o $@ t2/babygo-runtime.s t2/babygo-test.s

out2/my.o:  goas out2 t2/babygo-runtime.s t2/babygo-test.s
	./goas -o $@ t2/babygo-runtime.s t2/babygo-test.s


# Test asm files generated by babygo's self compiling
test3: out3/test.my.o out3/test.gnu.o
	diff $^

out3:
	mkdir -p $@

out3/test.my.o: goas out3 t3/babygo-runtime.s t3/babygo-main.s
	./goas -o $@ t3/babygo-runtime.s t3/babygo-main.s

out3/test.gnu.o: out3 t3/babygo-runtime.s t3/babygo-main.s
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
	./tool/compare-obj out4
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
