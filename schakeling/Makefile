.PHONY: all clean

all: src/ bin/ docs/ bin/schakeling.js bin/style.css bin/index.html docs/schakeling.html README.html
run:
	google-chrome bin/index.html
clean:
	rm -rf bin
	rm -rf docs
	rm -rf .sass-cache
	rm -f bin/style.css.map

%/:
	mkdir -p $@
bin/%.coffee: src/%.litcoffee
	# Extract code from schakeling.litcoffee and put in schakeling.coffee
	cat $< | grep '^    \|^$$' | sed -e 's/^    //' > $@
bin/%.js: src/%.litcoffee
	# Compile Coffeescript to Javascript
	coffee -o $(dir $@) -c $<
bin/%.css: src/%.sass
	# Compile SASS to CSS
	sass $< $@
bin/%.html: src/%.jade
	# Compile Jade to HTML
	jade -P -O '{"basedir":"bin"}' -o bin $<
docs/%.html: src/%.litcoffee
	# Create docs/schakeling.html
	docco $<
%.html: %.md
	# Create README.html
	ghmd $<