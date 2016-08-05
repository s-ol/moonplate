GAMENAME = my-game

MOON   = $(shell find -name '*.moon')
NATIVE = $(shell find lib -name '*.lua') main.lua conf.lua
ASSETS = $(shell find assets)
COMPILED  = $(MOON:.moon=.lua)

BIN = bin
DIST = dist
WINBINS = $(BIN)/win64 $(BIN)/win32

LOVE = $(NATIVE) $(ASSETS) $(COMPILED) heythere.txt

.PHONY: all run cleanbuild cleanbin clean dist kive win32 win64 mac

all: dist

run:
	love .

dist: win32 win64 mac love

clean:
	rm -f $(COMPILED)

cleanbuild:
	rm -rf $(DIST)/win32 $(DIST)/win64

cleanbin:
	rm -rf $(BIN)

$(COMPILED): %.lua: %.moon
	@moonc $?

$(DIST)/$(GAMENAME).love: $(LOVE)
	@mkdir -p $(DIST)
	@zip -9g $@ $?

love: $(DIST)/$(GAMENAME).love

$(WINBINS):
	@mkdir -p $(shell dirname $@)
	wget https://bitbucket.org/rude/love/downloads/love-0.10.1-win64.zip -O $@.zip
	@unzip -jod $@ $@.zip
	find $@ -exec touch {} ";"
	mv $@/love.exe $@/$(GAMENAME).exe
	rm $@/game.ico $@/changes.txt $@/readme.txt

$(BIN)/mac:
	@mkdir -p $@
	wget https://bitbucket.org/rude/love/downloads/love-0.10.1-macosx-x64.zip -O $@.zip
	@unzip -od $@ $@.zip
	find $@ -exec touch {} ";"
	mv $@/love.app $@/$(GAMENAME).app

win32: $(DIST)/$(GAMENAME).love $(BIN)/win32
	@cp -r $(BIN)/win32 $(DIST)/win32
	cat $(DIST)/$(GAMENAME).love >> $(DIST)/win32/$(GAMENAME).exe

win64: $(DIST)/$(GAMENAME).love $(BIN)/win64
	@cp -r $(BIN)/win64 $(DIST)/win64
	cat $(DIST)/$(GAMENAME).love >> $(DIST)/win64/$(GAMENAME).exe

mac: $(DIST)/$(GAMENAME).love $(BIN)/mac
	@cp -r $(BIN)/mac $(DIST)/mac
	cp $(DIST)/$(GAMENAME).love $(DIST)/mac/$(GAMENAME).app/Contents/Resources/
