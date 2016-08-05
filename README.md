moonpläte
=========

*moonpläte* is a template for [LÖVE](https://love2d.org) games using [moonscript](https://moonscript.org).

It uses a Makefile to build and bundle the source.

Usage
-----

First, add the game name in the `Makefile`s first line.

Boostrap your game from `init.moon` in moonscript and put Lua libraries in `lib`.
Use `make`, `make run` and `make clean` to build and distribute your `.love` files.
To update the love binaries run `make cleanbin` and `make` again.
