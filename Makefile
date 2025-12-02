SWIFTFLAGS = -O -whole-module-optimization -g

all: $(patsubst %.swift,%.exe,$(wildcard day*.swift))

day%.exe: day%.swift
	swiftc $(SWIFTFLAGS) -o $@ $<

# disable implicit rule
day%: ;

clean: FRC
	rm -f *.exe

FRC:
