mkdir bin
mkdir doc
mkdir include
mkdir lib
mkdir other
mkdir src
mkdir test
touch Makefile

cat >> Makefile << EOL
CC := gcc # This is the main compiler
# CC := clang --analyze # and comment out the linker last line for sanity
SRCDIR := src
BUILDDIR := build
TARGET := bin/runner
 
SRCEXT := c
SOURCES := \$(shell find \$(SRCDIR) -type f -name *.\$(SRCEXT))
OBJECTS := \$(patsubst \$(SRCDIR)/%,\$(BUILDDIR)/%,\$(SOURCES:.\$(SRCEXT)=.o))
CFLAGS := -g -Wall -Wextra
LIB := 
INC := -I include

\$(TARGET): \$(OBJECTS)
	@echo " Linking...";
	@echo " \$(CC) \$^ -o \$(TARGET) \$(LIB)"; \$(CC) \$^ -o \$(TARGET) \$(LIB)

\$(BUILDDIR)/%.o: \$(SRCDIR)/%.\$(SRCEXT)
	@mkdir -p \$(BUILDDIR)
	@echo " \$(CC) \$(CFLAGS) \$(INC) -c -o \$@ \$<"; \$(CC) \$(CFLAGS) \$(INC) -c -o \$@ \$<

clean:
	@echo " Cleaning..."; 
	@echo " \$(RM) -r \$(BUILDDIR) \$(TARGET)"; \$(RM) -r \$(BUILDDIR) \$(TARGET)

# Tests
tester:
	\$(CC) \$(CFLAGS) test/tester.cpp \$(INC) \$(LIB) -o bin/tester

# Spikes
ticket:
	\$(CC) \$(CFLAGS) spikes/ticket.cpp \$(INC) \$(LIB) -o bin/ticket

.PHONY: clean
EOL