CODEFILES: \
 $(shell groovy ../findScripts.groovy .. .md)

.PRECIOUS: %.java %.groovy

all: allScriptsCompiled scriptCount.tex

CLASSPATH_GROOVY=.

distclean: clean
	@rm -f *.md *.out *.bsh *.java *.groovy

clean:
	@rm -f *~ *.class allScriptsCompiled

scriptCount.tex: ${CODEFILES}
	@groovy ../findScripts.groovy .. .out | sort | uniq | wc -l > scriptCount.tex

allScriptsCompiled: ${CODEFILES}
	@touch allScriptsCompiled

%.md : %.ttl
	@echo "Processing " $<
	@groovy preprocess $<
