prefix	?= /usr
bindir := $(prefix)/bin
datadir := $(prefix)/share

all:
	cd src && qmake 
	cd src && make

clean:
	cd src && make clean

####### Install

install: 
	mkdir -p $(datadir)/krudio-qml
	mkdir -p $(datadir)/krudio-qml/data 
	install -Dm777 src/krudio-qml.desktop $(datadir)/applications/krudio-qml.desktop
	install -Dm777 src/data/* $(datadir)/krudio-qml/data/
	install -Dm777 src/krudio-qml $(bindir)/krudio-qml 
	chmod -R 777 $(datadir)/krudio-qml
uninstall: 
	rm -rf $(datadir)/krudio-qml
	rm $(datadir)/applications/krudio-qml.desktop
	rm $(bindir)/krudio-qml  
FORCE:
