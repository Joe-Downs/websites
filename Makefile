.SUFFIXES : .html .org .md .gmi
all : html md gmi

#===============================================================================

# Replace any ./*.org links with ./*.html links
html_sed = sed -E 's/(\.\/\S*\.)org/\1html/'
html_pages = index.html about.html tao.html credit.html recipes/pizzaDough.html blag/index.html blag/lfs-journey.html
html_out_css_template = -t html -c /css/retro.css --template=template.html --include-after-body=footer.html

.org.html :
	title=`jq -r '."$<"' titles.json`; \
	pandoc $< $(html_out_css_template) --metadata "title=$$title" | $(html_sed) > $@

$(html_pages) : template.html footer.html titles.json

html : $(html_pages)

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

