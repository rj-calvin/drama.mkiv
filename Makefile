CONTEXT ?= context
CONTEXTFLAGS ?= --batchmode
OUTDIR ?= out
products = $(patsubst %.tex,%.pdf,$(wildcard examples/*.tex))

all: $(products)

.PHONY: clean outdir

outdir:
	if [ ! -d $(OUTDIR) ]; then mkdir $(OUTDIR); fi

clean:
	rm -rf $(OUTDIR)

$(products): %.pdf: %.tex outdir
	cd $(OUTDIR); \
	$(CONTEXT) $(CONTEXTFLAGS) $(addprefix ../,$<)
