SOURCES := ${shell ls -1 *.i.md | grep -v indexList.i.md }
TARGETS := ${shell ls -1 *.i.md | sed -e 's/.i.md/.md/' | grep -v index.md }
METAS := references.dat toc.txt indexList.i.md sections.txt

SUBDIRS := code

all: ${SUBDIRS} ${METAS} ${TARGETS} index.md
	@mkdir -p docs/code/
	@mv ${TARGETS} docs/
	@cp code/*.md docs/code/
	@cp code/*.ttl docs/code/

sections.txt: order.txt ${SOURCES}
	@echo "Indexing the sections"
	@groovy findSections.groovy > sections.txt

toc.txt: makeToC.groovy order.txt ${SOURCES}
	@echo "Making the ToC"
	@groovy makeToC.groovy > toc.txt

indexList.i.md: topics.tsv makeIndex.groovy
	@echo "Making the index"
	@groovy makeIndex.groovy > indexList.i.md

topics.tsv: ${SOURCES} findTopics.groovy
	@echo "Extracting the topics"
	@groovy findTopics.groovy . | sort > topics.tsv

references.qids: findCitations.groovy
	@echo "Finding the citations"
	@groovy findCitations.groovy . | grep "^10" | sort | uniq > references.qids

references.dat: references.qids references.js
	@nodejs references.js

index.md: index.i.md toc.txt createMarkdown.groovy
	@echo "Creating $@"
	@mkdir -p docs/
	@groovy createMarkdown.groovy index.i.md > docs/index.md

%.md : %.i.md createMarkdown.groovy
	@echo "Creating $@"
	@groovy createMarkdown.groovy $< > $@

