.SUFFIXES : .html .org .md .gmi
all : html md gmi

repo_root = ..
css_file = retro.css

#===============================================================================
./css :
	mkdir ./css

css/$(css_file) : $(repo_root)/css/$(css_file) ./css
	cp $< ./css/$(css_file)

#===============================================================================
# Replace any ./*.org links with ./*.html links
html_sed = sed -E 's/(\.\/\S*\.)org/\1html/'
org_pages = $(shell find . -name '*.org')
html_pages = $(org_pages:.org=.html)
html_out_css_template = -t html --template=$(repo_root)/src/template.html --include-after-body=$(repo_root)/src/footer.html

.org.html :
	title=`jq -r '."$<"' titles.json`; \
	relative_css_file=`realpath css/$(css_file) --relative-to=$<`; \
	pandoc $< $(html_out_css_template) -c "$$relative_css_file" --metadata "title=$$title" | $(html_sed) > $@

$(html_pages) : $(repo_root)/src/template.html $(repo_root)/src/footer.html titles.json

# CSS needs to be "built" first so that it exists for realpath
html : css/$(css_file) $(html_pages)

#===============================================================================
# Pandoc escapes single and double quotes and asterisks when converting to
# Markdown... which translates to literal backslashes in gemtext, but doesn't
# with the older GitHub-flavored Markdown output mode (markdown_github rather
# than gfm). However, it does escape angled brackets, so we need to replace
# those with their literal counterparts.
md_sed = sed 's/\\</</' | sed 's/\\>/>/' | sed 's/\\\*/\*/'
md_pages = $(html_pages:.html=.md)

.org.md :
	pandoc $< -t markdown_github | $(md_sed) > $@

md : $(md_pages)

#===============================================================================
# Replace any ./*.org links with ./*.gmi links
gmi_sed = sed -E 's/(\.\/\S*\.)org/\1gmi/'
gmi_pages = $(md_pages:.md=.gmi)

.md.gmi :
	gemgen $<
	cat $@ | $(gmi_sed) > $@.tmp
	mv $@.tmp $@

gmi : $(gmi_pages)

#===============================================================================

clean :
	rm -f $(html_pages) $(md_pages) $(gmi_pages)
	rm -rf ./css

