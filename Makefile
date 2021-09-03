GOSOURCES = $(wildcard *.go)
SOURCES = $(wildcard *.s)
GNU_OBJS = $(SOURCES:%.s=%.gnu.o)
MY_OBJS = $(SOURCES:%.s=%.my.o)

.PHONY: diff
diff: objs
	diff 00.gnu.o 00.my.o
	diff 01.gnu.o 01.my.o
	diff 02.gnu.o 02.my.o
	diff 04.gnu.o 04.my.o
	diff 05.gnu.o 05.my.o
	diff 06.gnu.o 06.my.o
	diff 07.gnu.o 07.my.o
	diff 10.gnu.o 10.my.o
	diff 11.gnu.o 11.my.o

	@echo ok

.PHONY: objs
objs: $(GNU_OBJS) $(MY_OBJS)

%.gnu.o: %.s
	as -o $@ $<

%.my.o: %.s as
	./as -o $@ $<

as: $(GOSOURCES)
	go build -o as $(GOSOURCES)

t.gnu.o: ../src/runtime/runtime.s ../.shared/babygo-test.s
	as -o $@ $^

t.gnu.bin: t.gnu.o
	ld -e _rt0_amd64_linux -o $@ $<

t.my.o:  as ../src/runtime/runtime.s ../.shared/babygo-test.s
	./as -o $@ ../src/runtime/runtime.s ../.shared/babygo-test.s

t.my.bin: t.my.o as
	ld -e _rt0_amd64_linux -o $@ $<

test: t.my.bin t.gnu.bin
	./t.my.bin
	./t.gnu.bin

clean:
	rm -f as *.o *.bin

