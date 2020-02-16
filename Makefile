# Installation directories following GNU conventions
prefix ?= /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
sbindir = $(exec_prefix)/sbin
datarootdir = $(prefix)/share
datadir = $(datarootdir)
includedir = $(prefix)/include
mandir = $(datarootdir)/man

BIN=bin
OBJ=obj
SRC=src

CC ?= gcc
CFLAGS ?= -Wextra -Wall

.PHONY: all install uninstall clean

nms: $(OBJ)/nms.o $(OBJ)/main.o | $(BIN)
	$(CC) $(CFLAGS) -o $(BIN)/$@ $^

sneakers: $(OBJ)/nms.o $(OBJ)/sneakers.o | $(BIN)
	$(CC) $(CFLAGS) -o $(BIN)/$@ $^

all: nms sneakers

$(OBJ)/%.o: $(SRC)/%.c | $(OBJ)
	$(CC) $(CFLAGS) -o $@ -c $<

$(BIN):
	mkdir $(BIN)

$(OBJ):
	mkdir $(OBJ)

clean:
	rm -rf $(BIN)
	rm -rf $(OBJ)

install:
	install -d $(DESTDIR)$(bindir)
	cd $(BIN) && install * $(DESTDIR)$(bindir)

uninstall:
	if [ -f $(DESTDIR)$(bindir)/nms ]; then rm $(DESTDIR)$(bindir)/nms; fi;
	if [ -f $(DESTDIR)$(bindir)/sneakers ]; then rm $(DESTDIR)$(bindir)/sneakers; fi;
